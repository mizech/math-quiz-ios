import SwiftUI

struct AnswerButtonView: View {
	var caption: String
	var color: Color
	var action: () -> Void
	
    var body: some View {
		Button {
			action()
		} label: {
			Text(caption)
				.frame(height: 50)
				.frame(maxWidth: .infinity)
				.font(.title2)
				.fontWeight(.bold)
				.background(color)
				.foregroundStyle(.white)
				.clipShape(RoundedRectangle(cornerRadius: 12))
		}.padding(.bottom, 10)
    }
}

#Preview {
	AnswerButtonView(caption: "393", color: .gray) {}
}
