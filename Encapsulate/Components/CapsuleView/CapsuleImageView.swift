import SwiftUI
import SwiftData

struct CapsuleImageView: View {
    @Environment(\.modelContext) private var context
    let capsuleImage : CapsuleImage
    @State private var showMenu : Bool = false
    
    var body: some View {
        imageView
    }
}

extension CapsuleImageView {    
    @ViewBuilder private var imageView : some View {
        if let image = capsuleImage.image() {
            image
                .resizable()
                .frame(width: 200)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .contextMenu {
                    contextMenu
                }
                .overlay(alignment: .topTrailing) {
                    favouritesButton
                }
                .buttonStyle(.plain)
        }
    }
}

extension CapsuleImageView {
    private var favouritesButton : some View {
        Button {
            capsuleImage.isFavourite.toggle()
        } label: {
            Image(systemName: capsuleImage.isFavourite ? "heart.fill" : "heart")
                .font(.title3)
                .foregroundStyle(.red)
                .symbolEffect(.bounce, value: capsuleImage.isFavourite)
                .padding(5)
                .background(Color.darkGrayColor.opacity(0.6))
                .cornerRadius(8, corners: [.bottomLeft, .topRight])
        }
        .buttonStyle(.plain)
    }
    
    private var contextMenu : some View {
        VStack {
            MenuButton(title: capsuleImage.isFavourite ? "remove_from_favourites" : "add_to_favourites",
                       comment: "Remove/Add to favourites",
                       iconStr: capsuleImage.isFavourite ? "heart.fill" : "heart") {
                capsuleImage.isFavourite.toggle()
            }
            
            MenuButton(title: "delete_image", comment: "Delete image", iconStr: "trash.fill") {
                context.delete(capsuleImage)
            }
        }
    }
}
