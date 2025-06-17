import SwiftUI

struct AnswerButtonView: View {
	@Environment(MainViewModel.self) var mainVM
	@State var buttonColor = Color.gray
	
	var caption: Double
	var index: Int
	var action: () -> Void
	
	var body: some View {
		Button {
			action()
			mainVM.disabled = true
			mainVM.buttonColors[index] = .red
			mainVM.buttonColors[mainVM.answerIndex] = .green
			mainVM.disabled = true
		} label: {
			Text(caption.format())
				.frame(height: 50)
				.frame(maxWidth: .infinity)
				.font(.title2)
				.fontWeight(.bold)
				.background(mainVM.buttonColors[index])
				.foregroundStyle(.white)
				.clipShape(RoundedRectangle(cornerRadius: 12))
		}.padding(.bottom, 10)
			.disabled(mainVM.disabled == true)
	}
}

#Preview {
	AnswerButtonView(caption: 393, index: 0) {}
}
