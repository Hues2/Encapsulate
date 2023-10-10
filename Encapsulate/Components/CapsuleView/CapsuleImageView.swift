import SwiftUI
import SwiftData

struct CapsuleImageView: View {
    @Environment(\.modelContext) private var context
    let capsuleImage : CapsuleImage
    let image : Image
    @Binding var isShaking : Bool
    
    var body: some View {
        imageView
            .yieldTouches()
            .rotationEffect(Angle(degrees: isShaking ? -3 : 0))
            .animation(isShaking ? Animation.easeInOut(duration: 0.1).repeatForever(autoreverses: true) : Animation.default, value: isShaking)
            .onLongPressGesture(minimumDuration: 0.1) {
                self.isShaking.toggle()
            }
    }
}

extension CapsuleImageView {    
    private var imageView : some View {
        image
            .resizable()
            .frame(width: 200)
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .topTrailing) {
                Button {
                    capsuleImage.isFavourite.toggle()
                } label: {
                    Image(systemName: capsuleImage.isFavourite ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .padding(5)
                        .symbolEffect(.bounce, value: capsuleImage.isFavourite)
                        .background(Color.darkGrayColor.opacity(0.6))
                        .cornerRadius(8, corners: [.bottomLeft, .topRight])
                }
                .buttonStyle(.plain)
            }
            .overlay(alignment: .topLeading) {
                Button {
                    context.delete(capsuleImage)                    
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title3)
                        .foregroundStyle(.red)
                        .padding(5)
                        .symbolEffect(.bounce, value: capsuleImage.isFavourite)
                        .background(Color.darkGrayColor.opacity(0.6))
                        .cornerRadius(8, corners: [.bottomLeft, .topRight])
                }
            }
    }
}
