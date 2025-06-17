import SwiftUI

struct InitGameView: View {
	var mainVM: MainViewModel
	
    var body: some View {
		HStack {
			Button {
				mainVM.setInitValues()
			} label: {
				Text("Start Game".uppercased())
					.padding()
					.background(.green)
					.foregroundStyle(.white)
					.fontWeight(.bold)
					.clipShape(RoundedRectangle(cornerRadius: 12))
			}
		}.opacity(mainVM.isGameComplete == false ? 1 : 0)
    }
}

#Preview {
    InitGameView(mainVM: MainViewModel())
}
