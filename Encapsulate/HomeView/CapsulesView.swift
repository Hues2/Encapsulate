import SwiftUI

struct CapsulesView: View {
    let capsules : [Capsule]
    let proxy : ScrollViewProxy
    
    var body: some View {
        allCapsulesListView
    }
}

//MARK: - All Capsules View
extension CapsulesView {
    private var allCapsulesListView : some View {
        VStack(alignment: .leading, spacing: 0) {
            capsulesViewTitle
                .padding(.bottom)
            
            capsulesListView
        }
    }
    
    private var capsulesViewTitle : some View {
        Text("capsules:", comment: "Capsules:")
            .font(.title2)
            .fontWeight(.black)
            .foregroundStyle(Color.defaultTextColor)
            .padding(.horizontal)
    }
    
    private var capsulesListView : some View {
        VStack(spacing: 30) {
            ForEach(capsules) { capsule in
                capsuleRow(capsule)
                    .id(capsule)
            }
        }
    }
}

//MARK: - Capsule Row
extension CapsulesView {
    private func capsuleRow(_ capsule : Capsule) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            capsuleRowTitle(capsule.title, capsule.startDate, capsule.endDate)
            
            capsuleImagesView(capsule.capsuleImages)
        }
    }
    
    private func capsuleRowTitle(_ capsuleTitle : String, _ startDate : Date, _ endDate : Date) -> some View {
        HStack {
            Text(capsuleTitle)
                .font(.headline)
                .fontWeight(.semibold)
                .layoutPriority(1)
            Text("(\(startDate.toString()) - \(endDate.toString()))")
                .font(.subheadline)
                .fontWeight(.light)
                .layoutPriority(0)
        }
        .foregroundStyle(Color.defaultTextColor)
        .lineLimit(1)
        .padding(.horizontal)
    }
    
    private func capsuleImagesView(_ capsuleImages : [CapsuleImage]) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(zip(capsuleImages.indices, capsuleImages)), id: \.0) { (_, capsuleImage) in
                    if let image = capsuleImage.image() {
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
                    }
                }
            }
        }
        .contentMargins(.horizontal, 15, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
}
