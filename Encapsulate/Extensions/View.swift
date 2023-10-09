import SwiftUI

extension View {
    func withCardModifier(_ cardColor : Color) -> some View {
        modifier(CardViewModidifier(cardColor: cardColor))
    }
    
    func withMaterialCardModifier(_ material : Material) -> some View {
        modifier(MaterialCardViewModidifier(material: material))
    }
}


