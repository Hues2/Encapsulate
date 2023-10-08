import SwiftUI

extension View {
    func withCardModifier(_ cardColor : Color) -> some View {
        modifier(CardViewModidifier(cardColor: cardColor))
    }
}


