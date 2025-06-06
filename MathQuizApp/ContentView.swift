import SwiftUI

struct ContentView: View {
	var body: some View {
		VStack {
			Text("What's the result of")
				.font(.title)
			Text("47 * 11")
				.font(.largeTitle)
				.fontWeight(.bold)
			Text("?")
				.font(.title)
			Spacer()
			AnswerButtonView(caption: "498", color: .gray) {
				
			}
			AnswerButtonView(caption: "517", color: .gray) {
				
			}
			AnswerButtonView(caption: "507", color: .gray) {
				
			}
			AnswerButtonView(caption: "528", color: .gray) {
				
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
