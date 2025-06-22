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
					mainVM.newGame(hasGameStarted: true)
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
					VStack(alignment: .leading, spacing: 10) {
						Text("How to get or lose Points")
							.font(.title)
							.bold()
						Text("Correct answer within:")
							.font(.title2)
						HStack {
							Text("5 seconds")
							Spacer()
							Text("3 points")
						}
						HStack {
							Text("8 seconds")
							Spacer()
							Text("2 points")
						}
						HStack {
							Text("Afterwards")
							Spacer()
							Text("1 points")
						}
						HStack {
							Text("Wrong answer")
							Spacer()
							Text("Minus 1 point")
						}.bold()
							.foregroundStyle(.red)
						HStack {
							Text("Serie of 3 correct answers")
							Spacer()
							Text("5 points")
						}
						HStack {
							Text("Serie of 5 correct answers")
							Spacer()
							Text("5 points")
						}
						.padding(.bottom, 25)
						Button {
							isInfoSheetShown.toggle()
						} label: {
							Text("Got it! Let's go.")
								.frame(height: 50)
								.frame(maxWidth: .infinity)
								.background(.blue)
								.foregroundStyle(.white)
								.clipShape(RoundedRectangle(cornerRadius: 12))
								.bold()
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
