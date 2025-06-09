import SwiftUI

struct ContentView: View {
	@Environment(MainViewModel.self) var mainVM
	
	var body: some View {
		VStack {
			Text("What's the result of")
				.font(.title)
			Text("\(String(format: "%.2f", mainVM.operand1)) \(mainVM.ranOperator.rawValue) \(String(format: "%.2f", mainVM.operand2))")
				.font(.largeTitle)
				.fontWeight(.bold)
			Text("?")
				.font(.title)
			Spacer()
			AnswerButtonView(color: .gray, caption: mainVM.options[0], index: 0) {
				if 0 == mainVM.answerIndex {
					mainVM.points += 1
				}
			}
			AnswerButtonView(color: .gray, caption: mainVM.options[1], index: 1) {
				if 1 == mainVM.answerIndex {
					mainVM.points += 1
				}
			}
			AnswerButtonView(color: .gray, caption: mainVM.options[2], index: 2) {
				if 2 == mainVM.answerIndex {
					mainVM.points += 1
				}
			}
			AnswerButtonView(color: .gray, caption: mainVM.options[3], index: 3) {
				if 3 == mainVM.answerIndex {
					mainVM.points += 1
				}
			}
			Spacer()
			HStack {
				Text("\(mainVM.questionNumber) of 10")
					.font(.title2)
				Spacer()
				Text("^[\(mainVM.points) point](inflect: true)")
					.font(.title2)
					.fontWeight(.bold)
			}
			Spacer()
			Spacer()
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
