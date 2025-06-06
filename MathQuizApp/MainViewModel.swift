import Foundation

@Observable
class MainViewModel {
	var operand1 = 0
	var operand2 = 0
	var answer = 0
	var option1 = 0
	var option2 = 0
	var option3 = 0
	var option4 = 0
	
	init() {
		newQuestion()
	}
	
	func newQuestion() {
		operand1 = Int.random(in: 0...100)
		operand2 = Int.random(in: 0...100)
		answer = operand1 + operand2
		option1 = Int.random(in: 0...100) + Int.random(in: 0...100)
		option2 = Int.random(in: 0...100) + Int.random(in: 0...100)
		option3 = Int.random(in: 0...100) + Int.random(in: 0...100)
		option4 = Int.random(in: 0...100) + Int.random(in: 0...100)
	}
}
