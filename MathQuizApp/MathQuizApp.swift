import SwiftUI

@main
struct MathQuizApp: App {
	@State var mainVM = MainViewModel()
	
    var body: some Scene {
        WindowGroup {
			ContentView().environment(mainVM)
        }
    }
}
