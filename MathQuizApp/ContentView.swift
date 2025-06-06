import SwiftUI

struct ContentView: View {
	@State var mainVM = MainViewModel()
	
	var body: some View {
		VStack {
			Text("What's the result of")
				.font(.title)
			Text("\(mainVM.operand1) + \(mainVM.operand2)")
				.font(.largeTitle)
				.fontWeight(.bold)
			Text("?")
				.font(.title)
			Spacer()
			AnswerButtonView(caption: String(mainVM.option1), color: .gray) {
				
			}
			AnswerButtonView(caption: String(mainVM.option2), color: .gray) {
				
			}
			AnswerButtonView(caption: String(mainVM.option3), color: .gray) {
				
			}
			AnswerButtonView(caption: String(mainVM.option4), color: .gray) {
				
			}
			Spacer()
			Text("9")
				.font(.largeTitle)
			Text("3 of 10")
				.font(.title2)
			Spacer()
			Spacer()
		}
		.padding()
	}
}

#Preview {
	ContentView()
}
