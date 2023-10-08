import SwiftUI

struct CardViewModidifier : ViewModifier {
    let cardColor : Color
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(cardColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
