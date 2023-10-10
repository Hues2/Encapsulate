import SwiftUI
import SwiftData

struct CapsuleView: View {
    let capsule : Capsule
    @Query private var capsuleImages : [CapsuleImage]
    @State private var isShaking : Bool = false
    
    init(capsule : Capsule) {
        self.capsule = capsule
        let capsuleId = capsule.id
        let predicate = #Predicate<CapsuleImage> { capsuleImage in
            capsuleImage.capsule?.id == capsuleId
        }
        _capsuleImages = Query(filter: predicate)
    }
    
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
                ForEach(Array(zip(capsuleImages.indices, capsuleImages)), id: \.0) { (_, capsuleImage) in
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

