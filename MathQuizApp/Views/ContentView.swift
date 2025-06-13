import SwiftUI

struct ContentView: View {
	@Environment(MainViewModel.self) var mainVM
	@Environment(\.dismiss) var dismiss
	
	@State var isSheetShown = false
	@State var isWarningAlertShown = false
	
	var body: some View {
		NavigationStack {
			VStack {
				Text("What's the result of")
					.font(.title)
				Text(
					"\(mainVM.operand1.format()) " +
					"\(mainVM.ranOperator.rawValue) " +
					"\(mainVM.operand2.format())"
				)
				.font(.largeTitle)
				.fontWeight(.bold)
				Text("?")
					.font(.title)
				Spacer()
				AnswerButtonView(
					caption: mainVM.options[0],
					index: 0
				) {
					if 0 == mainVM.answerIndex {
						checkAnswer()
					}
				}
				AnswerButtonView(
					caption: mainVM.options[1],
					index: 1
				) {
					if 1 == mainVM.answerIndex {
						checkAnswer()
					}
				}
				AnswerButtonView(
					caption: mainVM.options[2],
					index: 2
				) {
					if 2 == mainVM.answerIndex {
						checkAnswer()
					}
				}
				AnswerButtonView(
					caption: mainVM.options[3],
					index: 3
				) {
					if 3 == mainVM.answerIndex {
						checkAnswer()
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
				ProgressView(value: (1.0 / mainVM.timeLimit) * mainVM.passedSeconds)
				Spacer()
				HStack {
					Spacer()
					Button {
						mainVM.newQuestion()
						mainVM.disabled = false
					} label: {
						Text("Next Question".uppercased())
							.padding()
							.background(.blue)
							.fontWeight(.bold)
							.foregroundStyle(.white)
							.clipShape(RoundedRectangle(cornerRadius: 12))
					}
					Spacer()
				}.opacity(mainVM.disabled == true ? 1 : 0)
				Spacer()
			}
			.toolbar(content: {
				ToolbarItem(placement: .topBarLeading) {
					Button("Restart", systemImage: "exclamationmark.triangle") {
						isWarningAlertShown.toggle()
					}
				}
			})
		}
		.alert("Reset Game?", isPresented: $isWarningAlertShown, actions: {
			Button("Reset") {
				mainVM.setInitValues()
			}
			Button("Cancel") {}
		}, message: {
			Text("Points will be lost.")
		})
		.sheet(isPresented: $isSheetShown, content: {
			VStack {
				Text("Game over").font(.title)
				Text("You have accomplished \(mainVM.points) points.")
				Button {
					mainVM.setInitValues()
					isSheetShown = false
				} label: {
					Text("Restart")
						.frame(height: 40)
						.frame(maxWidth: .infinity)
						.background(.blue)
						.foregroundStyle(.white)
						.clipShape(RoundedRectangle(cornerRadius: 12))
				}
			}.padding()
				.interactiveDismissDisabled(true)
		})
		.padding()
		.onChange(of: mainVM.isGameComplete) { _, newValue in
			if newValue == true {
				isSheetShown.toggle()
			}
		}
	}
	
	func checkAnswer() {
		if mainVM.passedSeconds < 4 {
			mainVM.points += 3
		} else if mainVM.passedSeconds < mainVM.timeLimit {
			mainVM.points += 2
		} else {
			mainVM.points += 1
		}
	}
}

#Preview {
	ContentView()
}
