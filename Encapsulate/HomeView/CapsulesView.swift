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
                CapsuleView(capsule: capsule)
                    .id(capsule)
            }
        }
    }
}
