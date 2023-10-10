import SwiftUI

struct CapsuleView: View {
    let capsule : Capsule
    @State private var isShaking : Bool = false
    
    var body: some View {
        capsuleRow            
    }
}

extension CapsuleView {
    private var capsuleRow : some View {
        VStack(alignment: .leading, spacing: 5) {
            capsuleRowTitle
            
            capsuleImagesView
        }
    }
    
    private var capsuleRowTitle : some View {
        HStack {
            Text(capsule.title)
                .font(.headline)
                .fontWeight(.semibold)
                .layoutPriority(1)
            Text("(\(capsule.startDate.toString()) - \(capsule.endDate.toString()))")
                .font(.subheadline)
                .fontWeight(.light)
                .layoutPriority(0)
        }
        .foregroundStyle(Color.defaultTextColor)
        .lineLimit(1)
        .padding(.horizontal)
    }
    
    private var capsuleImagesView : some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(zip(capsule.capsuleImages.indices, capsule.capsuleImages)), id: \.0) { (_, capsuleImage) in
                    if let image = capsuleImage.image() {
                        CapsuleImageView(capsuleImage: capsuleImage, image: image, isShaking: $isShaking)
                    }
                }
            }
        }
        .contentMargins(.horizontal, 15, for: .scrollContent)
        .contentMargins(.vertical, 1, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
}

