import SwiftUI

struct CapsuleCard: View {
    let capsule : Capsule
    let showShadow : Bool
    
    var body: some View {
        VStack {
            if let firstImageData = capsule.imagesData.first, let imageName = String(data: firstImageData, encoding: .utf8) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
            } else {
                noImageView
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(
            Color.clear
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

#Preview {
    CapsuleCard(capsule: Capsule(title: "Courtney & Jake Wedding", startDate: Date(), endDate: Date(), imagesData: []), showShadow: true)
        .frame(height: 350)
}
