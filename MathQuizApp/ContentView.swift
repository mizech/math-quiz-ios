import SwiftUI

struct ContentView: View {
	@State var mainVM = MainViewModel()
	
	var body: some View {
		VStack {
			Text("What's the result of")
				.font(.title)
			Text("\(mainVM.operand1) \(mainVM.ranOperator.rawValue) \(mainVM.operand2)")
				.font(.largeTitle)
				.fontWeight(.bold)
			Text("?")
				.font(.title)
			Spacer()
			AnswerButtonView(caption: String(mainVM.options[0]), color: .gray) {
				if 0 == mainVM.answerIndex {
					mainVM.points += 1
				}
				mainVM.newQuestion()
			}
			AnswerButtonView(caption: String(mainVM.options[1]), color: .gray) {
				if 1 == mainVM.answerIndex {
					mainVM.points += 1
				}
				mainVM.newQuestion()
			}
			AnswerButtonView(caption: String(mainVM.options[2]), color: .gray) {
				if 2 == mainVM.answerIndex {
					mainVM.points += 1
				}
				mainVM.newQuestion()
			}
			AnswerButtonView(caption: String(mainVM.options[3]), color: .gray) {
				if 3 == mainVM.answerIndex {
					mainVM.points += 1
				}
				mainVM.newQuestion()
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
