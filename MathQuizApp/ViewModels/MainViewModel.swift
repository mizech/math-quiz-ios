import Foundation
import SwiftUICore

@Observable
class MainViewModel {
	let timeLimit = 6.0
	var operators = [Operators]()
	var ranOperator = Operators.add
	var operand1: Double = 0
	var operand2: Double = 0
	var answer: Double = 0
	var answerIndex = 0
	var options = [Double]()
	var questionNumber = 0
	var points = 0
	var disabled = false
	var isGameComplete = false
	var passedSeconds: Double = 0
	var buttonColors = [
		Color.gray,
		Color.gray,
		Color.gray,
		Color.gray
	]
	
	func setInitValues() {
		answerIndex = 0
		questionNumber = 0
		points = 0
		disabled = false
		isGameComplete = false
		newQuestion()
	}
	
	init() {
		for curr in Operators.allCases {
			operators.append(curr)
		}
		setInitValues()
	}
	
	func newQuestion() {
		operand1 = Double.random(in: 0...100)
		operand2 = Double.random(in: 1..<100)
		ranOperator = operators.randomElement() ?? Operators.subtract
		options.removeAll()
		
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
		
		if questionNumber < 10 {
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
		passedSeconds = 0
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
