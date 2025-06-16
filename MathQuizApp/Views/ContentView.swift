import SwiftUI

struct ContentView: View {
	@Environment(MainViewModel.self) var mainVM
	
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
					checkAnswer(index: 0)
				}
				AnswerButtonView(
					caption: mainVM.options[1],
					index: 1
				) {
					checkAnswer(index: 1)
				}
				AnswerButtonView(
					caption: mainVM.options[2],
					index: 2
				) {
					checkAnswer(index: 2)
				}
				AnswerButtonView(
					caption: mainVM.options[3],
					index: 3
				) {
					checkAnswer(index: 3)
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
					Button {
						
					} label: {
						Text("Start Game".uppercased())
							.padding()
							.background(.green)
							.fontWeight(.bold)
							.foregroundStyle(.white)
							.clipShape(RoundedRectangle(cornerRadius: 12))
					}

				}.opacity(mainVM.isGameComplete == true ? 1 : 0)
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
	
	func checkAnswer(index: Int) {
		if index == mainVM.answerIndex {
			if mainVM.passedSeconds < 4 {
				mainVM.points += 3
			} else if mainVM.passedSeconds < mainVM.timeLimit {
				mainVM.points += 2
			} else {
				mainVM.points += 1
			}
		} else {
			mainVM.points -= 1
		}
	}
}

#Preview {
	ContentView()
}
