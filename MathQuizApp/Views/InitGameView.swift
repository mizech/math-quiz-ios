import SwiftUI

struct InitGameView: View {
	@State var selectedAmount = 10
	@State var isInfoSheetShown = false
	
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
						isInfoSheetShown.toggle()
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
			.sheet(isPresented: $isInfoSheetShown) {
				NavigationStack {
					VStack(spacing: 10) {
						Text("How to get or lose Points")
							.font(.title)
							.bold()
						Text("Answered correct within:")
							.font(.title2)
						Text("5 seconds\t\t3 points")
						Text("3 seconds\t\t2 points")
						Text("Afterwards\t\t1 points")
						Text("Wrong answer\t\tminus 1 point")
							.padding(.bottom, 25)
						Button {
							isInfoSheetShown.toggle()
						} label: {
							Text("Got it!")
								.frame(height: 50)
								.frame(maxWidth: .infinity)
								.background(.blue)
								.foregroundStyle(.white)
								.clipShape(RoundedRectangle(cornerRadius: 12))
						}

						Spacer()
					}
					.padding()
					.toolbar {
						ToolbarItem(placement: .topBarTrailing) {
							Button {
								isInfoSheetShown.toggle()
							} label: {
								Image(systemName: "multiply.circle.fill")
							}
						}
					}
				}
			}
	}
}

#Preview {
	InitGameView(mainVM: MainViewModel())
}
