import SwiftUI

struct CapsulesView: View {
    let capsules : [Capsule]
    
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
        VStack(spacing: 25) {
            ForEach(capsules) { capsule in
                capsuleRow(capsule)
            }
        }
    }
}

//MARK: - Capsule Row
extension CapsulesView {
    private func capsuleRow(_ capsule : Capsule) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            capsuleRowTitle(capsule.title, capsule.startDate, capsule.endDate)
            
            capsuleImagesView(capsule.images())
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
    
    private func capsuleImagesView(_ capsuleImages : [Image]) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(zip(capsuleImages.indices, capsuleImages)), id: \.0) { (_, image) in
                    image
                        .resizable()
                        .frame(width: 200)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .contentMargins(.horizontal, 15, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
}
