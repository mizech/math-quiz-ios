import Foundation
import SwiftUICore

@Observable
class MainViewModel {
	let timeLimit = 8.0
	let operators = [
		Operators.add,
		Operators.subtract,
		Operators.multiply,
		Operators.divide
	]
	
	var answerIndex = 0
	var questionNumber = 0
	var points = 0
	var disabled = false
	var isGameComplete = false
	var amountQuestions = 10
	var amountCorrectQuestions = 0
	var hasGameStarted = false
	var passedSeconds: Double = 0
	var serieCorrectAnswers = 0
	var currSum = 0
	
	var operand1: Double = 0
	var operand2: Double = 0
	var ranOperator = Operators.add
	var options = [Double]()
	var answer: Double = 0
	var buttonColors = [
		Color.gray,
		Color.gray,
		Color.gray,
		Color.gray
	]
	
	func newGame() {
		self.answerIndex = 0
		self.questionNumber = 0
		self.points = 0
		self.disabled = false
		self.isGameComplete = false
		self.hasGameStarted = false
	}
	
	func startGame(amountQuestions: Int) {
		self.amountQuestions = amountQuestions
		self.amountCorrectQuestions = 0
		self.hasGameStarted = true
		newQuestion()
	}
	
	func newQuestion() {
		operand1 = Double.random(in: 0...100)
		operand2 = Double.random(in: 1..<100)
		ranOperator = operators.randomElement() ?? Operators.subtract
		options.removeAll()
		passedSeconds = 0
		disabled = false
		currSum = 0
		
		switch ranOperator {
			case .add:
				answer = operand1 + operand2
				setUpQuestion {
					Double.random(
						in: operand1 - 5.0...operand1 + 5.0
					) + Double.random(
						in: operand1 - 5.0...operand1 + 5.0
					)
				}
			case .subtract:
				answer = operand1 - operand2
				setUpQuestion {
					Double.random(
						in: operand1 - 5.0...operand1 + 5.0
					) + Double.random(
						in: operand1 - 5.0...operand1 + 5.0
					)
				}
			case .multiply:
				answer = operand1 * operand2
				setUpQuestion {
					Double.random(
						in: operand1 - 1.0...operand1 + 1.0
					) + Double.random(
						in: operand1 - 1.0...operand1 + 1.0
					)
				}
			case .divide:
				answer = operand1 / operand2
				setUpQuestion {
					Double.random(
						in: operand1 - 1.0...operand1 + 1.0
					) + Double.random(
						in: operand1 - 1.0...operand1 + 1.0
					)
				}
		}
		
		if questionNumber < amountQuestions {
			questionNumber += 1
		} else {
			isGameComplete = true
		}
		
		for i in 0..<buttonColors.count {
			buttonColors[i] = .gray
		}
		
		Task {
			while disabled == false {
				if passedSeconds < timeLimit {
					do {
						try await Task.sleep(for: .seconds(1))
					} catch {
						print(error)
					}
					
					passedSeconds += 1
				}
			}
		}
	}
	
	func setUpQuestion(compOption: () -> Double) {
		answerIndex = Int.random(in: 0..<4)
		
		for i in 0..<4 {
			if i == answerIndex {
				options.append(answer)
			} else {
				options.append(compOption())
			}
		}
	}
}
