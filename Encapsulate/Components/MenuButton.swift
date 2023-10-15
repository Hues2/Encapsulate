import SwiftUI

struct MenuButton: View {
    let title : LocalizedStringKey
    let comment : StaticString
    let iconStr : String?
    let action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title, comment: comment)
                if let iconStr {
                    Image(systemName: iconStr)
                }
            }
        }
    }
}
