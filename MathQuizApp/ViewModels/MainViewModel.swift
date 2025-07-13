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
	var selectedDifficulty = Difficulty.easy
	
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
	
	var getRange: ClosedRange<Double> {
		switch ranOperator {
			case .add, .subtract:
				switch selectedDifficulty {
					case .easy:
						return 2...15
					case .medium:
						return 1...10
					case .hard:
						return 1...5
				}
			case .multiply:
				switch selectedDifficulty {
					case .easy:
						return 10...100
					case .medium:
						return 10...50
					case .hard:
						return 5...50
				}
			case .divide:
				switch selectedDifficulty {
					case .easy:
						return 2...15
					case .medium:
						return 1...10
					case .hard:
						return 1...5
				}
		}
	}
	
	func newGame() {
		self.answerIndex = 0
		self.questionNumber = 0
		self.points = 0
		self.disabled = false
		self.isGameComplete = false
		self.hasGameStarted = false
		selectedDifficulty = Difficulty.medium
	}
	
	func startGame(amountQuestions: Int) {
		self.amountQuestions = amountQuestions
		self.amountCorrectQuestions = 0
		self.hasGameStarted = true
		newQuestion()
	}
	
	func newQuestion() {
		let upperLimit = selectedDifficulty == .easy ? 10.0 : 100.0
		operand1 = round(Double.random(in: 0...upperLimit) * upperLimit) / upperLimit
		operand2 = round(Double.random(in: 1..<upperLimit) * upperLimit) / upperLimit
		
		ranOperator = operators.randomElement() ?? Operators.subtract
		options.removeAll()
		passedSeconds = 0
		disabled = false
		currSum = 0
		
		switch ranOperator {
			case .add:
				answer = round((operand1 + operand2) * 100) / 100
				setUpQuestion(operand: Operators.add)
			case .subtract:
				answer = round((operand1 - operand2) * 100) / 100
				setUpQuestion(operand: Operators.subtract)
			case .multiply:
				answer = round((operand1 * operand2) * 100) / 100
				setUpQuestion(operand: Operators.multiply)
			case .divide:
				answer = round((operand1 / operand2) * 100) / 100
				setUpQuestion(operand: Operators.divide)
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
	
	func setUpQuestion(operand: Operators) {
		answerIndex = Int.random(in: 0..<4)
		
		for i in 0..<4 {
			if i == answerIndex {
				options.append(answer)
			} else {
				while true {
					var feasibleOption: Double = 0
					var isPositive = Double.random(in: 0...1.0) >= 0.5
					
					switch operand {
						case .add, .subtract:
							feasibleOption = isPositive ? answer + Double.random(in: getRange) : answer - Double.random(in: getRange)
						case .multiply:
							feasibleOption = isPositive ? answer + Double.random(in: getRange) : answer - Double.random(in: getRange)
						case .divide:
							feasibleOption = isPositive ? answer + Double.random(in: getRange) : abs(answer - Double.random(in: getRange))
					}
					
					feasibleOption = round(feasibleOption * 100) / 100
					
					if options.contains(feasibleOption) == true {
						continue
					} else {
						options.append(feasibleOption)
						break
					}
				}
			}
		}
	}
}
