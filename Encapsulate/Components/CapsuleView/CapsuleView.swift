import SwiftUI
import SwiftData

struct CapsuleView: View {
    @Environment(\.modelContext) private var context
    let capsule : Capsule
    @Query private var capsuleImages : [CapsuleImage]
    @State private var showDeleteAlert : Bool = false
    
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
            .alert("delete_capsule_alert_title", isPresented: $showDeleteAlert) {
                Button(role: .destructive) {
                    context.delete(capsule)
                } label: {
                    Text("Delete")
                        .foregroundStyle(.red)
                }
            }
    }
}

extension CapsuleView {
    private var capsuleRow : some View {
        VStack(alignment: .leading, spacing: 15) {
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
            Spacer()
            Menu {
                menuButtons
            } label: {
                Image(systemName: "ellipsis.circle")
                    .font(.headline)
                    .contentShape(Rectangle())
            }
        }
        .foregroundStyle(Color.defaultTextColor)
        .lineLimit(1)
        .padding(.horizontal)
    }
    
    private var capsuleImagesView : some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(Array(zip(capsuleImages.indices, capsuleImages)), id: \.0) { (_, capsuleImage) in
                    CapsuleImageView(capsuleImage: capsuleImage)
                }
            }
        }
        .contentMargins(.horizontal, 15, for: .scrollContent)
        .contentMargins(.vertical, 1, for: .scrollContent)
        .scrollIndicators(.hidden)
    }
    
    private var menuButtons : some View {
        VStack {
            MenuButton(title: "share_capsule", comment: "Share Capsule", iconStr: "square.and.arrow.up") {
                // TODO: Share capsule functionality
                print("Share Capsule")
            }
            
            MenuButton(title: "delete_capsule", comment: "Delete Capsule", iconStr: "trash") {
                withAnimation {
                    self.showDeleteAlert = true
                }
            }
        }
    }
}

