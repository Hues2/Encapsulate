import SwiftUI

struct HighlightCapsulesView: View {
    let capsules : [Capsule]
    let proxy : ScrollViewProxy
    
    var body: some View {
        highlightCapsulesView
    }
}

extension HighlightCapsulesView {
    private var highlightCapsulesView : some View {
        VStack(alignment: .leading, spacing: 0) {
            highlightsTitle
            
            horizontalScrollview
        }
    }
    
    private var highlightsTitle : some View {
        Text("highlights", comment: "Highlights:")
            .font(.title2)
            .fontWeight(.black)
            .foregroundStyle(Color.defaultTextColor)
            .padding(.horizontal)
    }
    
    private var horizontalScrollview : some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(capsules) { capsule in
                    capsuleCardView(capsule)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                proxy.scrollTo(capsule)
                            }
                        }
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
    
    private func capsuleCardView(_ capsule : Capsule) -> some View {
        CapsuleCard(capsule: capsule, showShadow: true)
            .frame(maxWidth: .infinity)
            .frame(height: 400)
            .padding()
            .containerRelativeFrame(.horizontal, count: 1, spacing: 10)
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.3)
                    .scaleEffect(phase.isIdentity ? 1 : 0.3)
            }
    }
}
