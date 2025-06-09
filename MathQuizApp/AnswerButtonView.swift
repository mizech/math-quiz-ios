import SwiftUI

struct AnswerButtonView: View {
	@Environment(MainViewModel.self) var mainVM
	@State var color: Color
	
	var caption: Double
	var index: Int
	var action: () -> Void
	
    var body: some View {
		Button {
			action()
			mainVM.disabled = true
			if index == mainVM.answerIndex {
				self.color = .green
			} else {
				self.color = .red
			}
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
				color = .gray
				mainVM.newQuestion()
				mainVM.disabled = false
			}
		} label: {
			Text(String(format: "%.2f", caption))
				.frame(height: 50)
				.frame(maxWidth: .infinity)
				.font(.title2)
				.fontWeight(.bold)
				.background(color)
				.foregroundStyle(.white)
				.clipShape(RoundedRectangle(cornerRadius: 12))
		}.padding(.bottom, 10)
			.disabled(mainVM.disabled == true)
    }
}

#Preview {
	AnswerButtonView(color: .gray, caption: 393, index: 0) {}
}
