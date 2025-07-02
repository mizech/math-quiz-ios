import SwiftUI

struct ResultView: View {
	var mainVM: MainViewModel
	
	@Binding var isSheetShown: Bool

    var body: some View {
		NavigationStack {
			VStack(spacing: 15) {
				Text("Game over").font(.largeTitle)
					.padding(.bottom)
					.fontWeight(.bold)
				Text("\(mainVM.points) points in total")
					.font(.title)
				Text("\(mainVM.amountCorrectQuestions) questions out of \(mainVM.amountQuestions) correct")
					.font(.title2)
				Spacer()
				Button {
					mainVM.newGame()
					isSheetShown = false
				} label: {
					Text("Reset")
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
		}
    }
}

#Preview {
	ResultView(
		mainVM: MainViewModel(),
		isSheetShown: .constant(true)
	)
}
