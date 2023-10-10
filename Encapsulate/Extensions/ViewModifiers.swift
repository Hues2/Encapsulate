import SwiftUI

//MARK: - Card Modifier, applies a color background
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

//MARK: - Card Modifier, applies a material background
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

//MARK: - Allows scrolling CapsuleImages with a LongPressapGesture
struct YieldTouches : ViewModifier {
    @State private var disabled = false
    
    func body(content: Content) -> some View {
        content
            .disabled(disabled)
            .onTapGesture { onMain { disabled = true; onMain { disabled = false }}}
    }
    
    private func onMain(_ action: @escaping () -> Void) { DispatchQueue.main.async(execute: action) }
}
