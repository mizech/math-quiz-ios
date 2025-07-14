import SwiftUI

struct InitGameView: View {
	@State var selectedAmount = 10
	@State var selectedDifficulty = Difficulty.easy
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
			Section("Difficulty") {
				Picker("Difficulty", selection: $selectedDifficulty) {
					ForEach(Difficulty.allCases, id: \.self) { option in
						switch option {
							case .easy:
								Text(String(localized: "Easy") + " 😀")
									.tag(option)
							case .hard:
								Text(String(localized: "Hard") + " 😬")
									.tag(option)
						}
					}
				}.pickerStyle(.segmented)
			}
			Section {
				Button {
					mainVM.startGame(amountQuestions: selectedAmount)
				} label: {
					Text(String(localized: "Start Game").uppercased() + " 🚀")
						.padding()
						.frame(height: 50)
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
			.onChange(of: selectedDifficulty, { 
				mainVM.selectedDifficulty = selectedDifficulty
			})
			.sheet(isPresented: $isInfoSheetShown) {
				NavigationStack {
					VStack(alignment: .leading, spacing: 10) {
						Text("How to get or lose Points")
							.font(.title2)
							.bold()
						Text("Correct answer within:")
							.font(.title3)
						HStack {
							Text("5 seconds")
							Text("🥉")
							Spacer()
							Text("3 points")
						}
						HStack {
							Text("8 seconds")
							Spacer()
							Text("2 points")
						}
						HStack {
							Text("> 8 seconds")
							Spacer()
							Text("1 points")
						}
						HStack {
							Text("Wrong answer")
							Text("😖")
							Spacer()
							Text("Minus 1 point")
						}.bold()
							.foregroundStyle(.red)
						HStack {
							Text("Serie of 3 correct answers")
							Text("🥈")
							Spacer()
							Text("5 points")
						}
						HStack {
							Text("Serie of 5 correct answers")
							Text("🥇")
							Spacer()
							Text("10 points")
						}
						.padding(.bottom, 25)
						Button {
							isInfoSheetShown.toggle()
						} label: {
							Text("Okay".uppercased() + " 👍")
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
