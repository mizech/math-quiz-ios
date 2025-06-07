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
				
			}
			AnswerButtonView(caption: String(mainVM.options[1]), color: .gray) {
				
			}
			AnswerButtonView(caption: String(mainVM.options[2]), color: .gray) {
				
			}
			AnswerButtonView(caption: String(mainVM.options[3]), color: .gray) {
				
			}
			Spacer()
			HStack {
				Text("\(mainVM.questionNumber) of 10")
					.font(.title2)
				Spacer()
				Text("9 Points")
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
