import SwiftUI

struct ResultView: View {
	var mainVM: MainViewModel
	
	@Binding var isSheetShown: Bool
	// TODO: Report how many questions out of X are correct.
	// TODO: Improved app-icon.
    var body: some View {
		NavigationStack {
			VStack {
				Text("Game over").font(.largeTitle)
					.padding(.bottom)
				Text("You have accomplished \(mainVM.points) points.")
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
