import SwiftUI

struct ResultView: View {
	var mainVM: MainViewModel
	
	@Binding var isSheetShown: Bool
	@State var smiley = "🫤"

    var body: some View {
		NavigationStack {
			VStack(spacing: 15) {
				Text(String(localized: "Game over") + " ‼").font(.largeTitle)
					.padding(.bottom)
					.fontWeight(.bold)
				HStack {
					Text("Selected Difficulty: ")
						.fontWeight(.bold)
					switch mainVM.selectedDifficulty {
						case .easy:
							Text("Easy")
						case .hard:
							Text("Hard")
					}
				}.font(.title2)
				Text("\(mainVM.amountCorrectQuestions) questions out of \(mainVM.amountQuestions) correct")
					.font(.title2)
				Text(smiley).font(.system(size: 64))
				Text("\(mainVM.points) points in total")
					.font(.title)
					.fontWeight(.bold)
				Spacer()
				Button {
					mainVM.newGame()
					isSheetShown = false
				} label: {
					Text(String(localized: "Reset").uppercased() + " ⤴")
						.frame(height: 50)
						.frame(maxWidth: .infinity)
						.bold()
						.background(.blue)
						.foregroundStyle(.white)
						.clipShape(RoundedRectangle(cornerRadius: 12))
				}
				Spacer()
			}.padding()
			.interactiveDismissDisabled(true)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						mainVM.newGame()
						isSheetShown = false
					} label: {
						Image(systemName: "multiply.circle.fill")
					}
				}
			}
		}.onAppear() {
			let percentageCorrect = Double((mainVM.amountCorrectQuestions * 100)
									   / mainVM.amountQuestions)
			switch percentageCorrect {
				case 0...30:
					smiley = "🫤"
				case 31...60:
					smiley = "😑"
				case 61...80:
					smiley = "🙂"
				default:
					smiley = "😃"
			}
		}
    }
}

#Preview {
	ResultView(
		mainVM: MainViewModel(),
		isSheetShown: .constant(true)
	)
}
