import SwiftUI

struct ResultView: View {
	var mainVM: MainViewModel
	
	@Binding var isSheetShown: Bool
	
    var body: some View {
		VStack {
			Text("Game over").font(.title)
			Text("You have accomplished \(mainVM.points) points.")
			Button {
				mainVM.setInitValues(hasGameStarted: false)
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
    }
}

#Preview {
	ResultView(
		mainVM: MainViewModel(),
		isSheetShown: .constant(true)
	)
}
