import SwiftUI

struct ContentView: View {
	@Environment(MainViewModel.self) var mainVM
	
	var body: some View {
		NavigationStack {
			if mainVM.hasGameStarted {
				ActiveGameView(mainVM: mainVM)
			} else {
				InitGameView(mainVM: mainVM)
			}
		}
	}
}

#Preview {
	ContentView()
}
