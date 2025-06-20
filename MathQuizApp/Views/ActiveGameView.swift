import SwiftUI

struct ActiveGameView: View {
	@State var isWarningAlertShown = false
	@State var isSheetShown = false
	
	var mainVM: MainViewModel
	
	var body: some View {
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
			ForEach(0...3, id: \.self) { i in
				AnswerButtonView(
					caption: mainVM.options[i],
					index: i
				) {
					checkAnswer(index: i)
				}
			}
			Spacer()
			HStack {
				Text("\(mainVM.questionNumber) of \(mainVM.amountQuestions)")
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
					withAnimation {
						mainVM.disabled = false
					}
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
		.toolbar(
			content: {
				ToolbarItem(placement: .topBarLeading) {
					Button(
						"Restart",
						systemImage: "exclamationmark.triangle"
					) {
					isWarningAlertShown.toggle()
				}
			}
		})
		.padding()
		.onChange(of: mainVM.isGameComplete) { _, newValue in
			if newValue == true {
				isSheetShown.toggle()
			}
		}.alert("Reset Game?", isPresented: $isWarningAlertShown, actions: {
			Button("Reset") {
				mainVM.setInitValues(hasGameStarted: false)
			}
			Button("Cancel") {}
		}, message: {
			Text("Points will be lost.")
		})
		.sheet(isPresented: $isSheetShown, content: {
			ResultView(mainVM: mainVM, isSheetShown: $isSheetShown)
		})
	}
	
	func checkAnswer(index: Int) {
		if index == mainVM.answerIndex {
			if mainVM.passedSeconds < 5 {
				mainVM.points += 3
			} else if mainVM.passedSeconds < mainVM.timeLimit {
				mainVM.points += 2
			} else {
				mainVM.points += 1
			}
		} else {
			if mainVM.points > 0 {
				mainVM.points -= 1
			}
		}
	}
}

#Preview {
	ActiveGameView(mainVM: MainViewModel())
}
