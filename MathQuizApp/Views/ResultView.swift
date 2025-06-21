import SwiftUI

struct ResultView: View {
	var mainVM: MainViewModel
	
	@Binding var isSheetShown: Bool
	
    var body: some View {
		NavigationStack {
			VStack {
				Text("Game over").font(.largeTitle)
					.padding(.bottom)
				Text("You have accomplished \(mainVM.points) points.")
					.font(.title2)
				Spacer()
				Button {
					mainVM.setInitValues(hasGameStarted: false)
					isSheetShown = false
				} label: {
					Text("Restart")
						.frame(height: 40)
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
