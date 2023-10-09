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

struct MaterialCardViewModidifier : ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    let material : Material
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(material, in: RoundedRectangle(cornerRadius: 8))
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(colorScheme == .dark ? Color.accentColor : Color.secondAccentColor)
            }
    }
}
