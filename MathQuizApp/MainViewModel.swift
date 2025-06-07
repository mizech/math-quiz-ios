import Foundation

@Observable
class MainViewModel {
	var operators = [Operators]()
	var ranOperator = Operators.add
	var operand1 = 0
	var operand2 = 0
	var answer = 0
	var options = [Int]()
	var questionNumber = 0
	var correctIndex = 0
	
	init() {
		for curr in Operators.allCases {
			operators.append(curr)
		}
		newQuestion()
	}
	
	func newQuestion() {
		operand1 = Int.random(in: 0...100)
		operand2 = Int.random(in: 0...100)
		ranOperator = operators.randomElement() ?? Operators.subtract
		
		switch ranOperator {
			case .add:
				answer = operand1 + operand2
				setUpQuestion { Int.random(in: 0...100) + Int.random(in: 0...100) }
			case .subtract:
				answer = operand1 - operand2
				setUpQuestion { Int.random(in: 0...100) - Int.random(in: 0...100) }
			case .multiply:
				answer = operand1 * operand2
				setUpQuestion { Int.random(in: 0...100) * Int.random(in: 0...100) }
			case .divide:
				answer = operand1 / operand2
				setUpQuestion { Int.random(in: 0...100) / Int.random(in: 0...100) }
		}
		
		questionNumber += 1
	}
	
	func setUpQuestion(compOption: () -> Int) {
		correctIndex = Int.random(in: 0..<4)
		
		for i in 0..<4 {
			if i == correctIndex {
				options.append(answer)
			} else {
				options.append(compOption())
			}
		}
	}
}
