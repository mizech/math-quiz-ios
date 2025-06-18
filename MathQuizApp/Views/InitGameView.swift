import SwiftUI

struct InitGameView: View {
	@State var selectedAmount = 10
	
	var mainVM: MainViewModel
	let feasibleAmounts = [5, 10, 15, 20]
	
    var body: some View {
		Form {
			Section("Amount Questions") {
				Picker("Amount Questions", selection: $selectedAmount) {
					ForEach(feasibleAmounts, id: \.self) { i in
						Text("\(i)")
					}
				}.pickerStyle(.wheel)
			}
			Section {
				Button {
					mainVM.setInitValues(hasGameStarted: true)
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
			.onChange(of: selectedAmount) {
				mainVM.amountQuestions = selectedAmount
			}
    }
}

#Preview {
    InitGameView(mainVM: MainViewModel())
}
