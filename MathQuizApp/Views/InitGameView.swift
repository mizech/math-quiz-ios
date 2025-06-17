import SwiftUI

struct InitGameView: View {
	var mainVM: MainViewModel
	@State var amountQuestions = 15
	
    var body: some View {
		Form {
			Section("Amount Questions") {
				Picker("Amount Questions", selection: $amountQuestions) {
					ForEach(1...3, id: \.self) { i in
						Text("\(i * 10)")
					}
				}.pickerStyle(.wheel)
			}
			Section {
				Button {
					mainVM.setInitValues()
				} label: {
					Text("Start Game".uppercased())
						.padding()
						.frame(height: 40)
						.frame(maxWidth: .infinity)
						.background(.green)
						.foregroundStyle(.white)
						.fontWeight(.bold)
						.clipShape(RoundedRectangle(cornerRadius: 12))
				}
			}
			Section("Instructions") {
				HStack {
					Spacer()
					Button {
						
					} label: {
						Image(systemName: "info.circle.fill")
							.font(.largeTitle)
					}
					Spacer()
				}
			}
		}.opacity(mainVM.isGameComplete == false ? 1 : 0)
    }
}

#Preview {
    InitGameView(mainVM: MainViewModel())
}
