import SwiftUI

struct CapsuleCard: View {
    private let capsule : Capsule
    private let showShadow : Bool
    private var thumbnailImage : Image?
    
    init(capsule: Capsule, showShadow: Bool) {
        self.capsule = capsule
        self.showShadow = showShadow
        self.thumbnailImage = setThumbnailImage(capsule)
    }
    
    var body: some View {
        VStack {
            if let thumbnailImage {
                thumbnailImage
                    .resizable()
            } else {
                noImageView
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(
            Color.backgroundColor
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.6), radius: showShadow ? 5 : 0)
        )
        .overlay(alignment: .bottom) {
            overlay
                .clipped()
        }
    }
}

extension CapsuleCard {
    private var overlay : some View {
        Text(capsule.title)
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(Color.darkGrayColor.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private var noImageView : some View {
        VStack(spacing: 10) {
            Image(systemName: "camera.fill")
                .font(.title)
                .foregroundStyle(LinearGradient(colors: [.accent, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing))
            Text("no_images_available", comment: "No images available")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.defaultTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension CapsuleCard {
    private func setThumbnailImage(_ capsule : Capsule) -> Image? {
        guard let capsuleImage = capsule.capsuleImages.first,
              let uiImage = UIImage(data: capsuleImage.data) else { return nil }
        return Image(uiImage: uiImage)
    }
}
