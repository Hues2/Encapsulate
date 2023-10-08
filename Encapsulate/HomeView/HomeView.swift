import SwiftUI

struct HomeView: View {
    @State private var recentCapsules : [Capsule] = []
    @State private var showAddCapsuleSheet : Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            highlightCapsulesView
                .padding(.top, 20)
            
            Spacer()

        }
        .frame(maxHeight: .infinity)
        .background(Color.backgroundColor.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                title("home_navigation_title")
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        self.showAddCapsuleSheet = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .contentShape(Rectangle())
            }
        }
        .sheet(isPresented: $showAddCapsuleSheet, content: {
            AddCapsuleSheetView(showAddCapsuleSheet: $showAddCapsuleSheet)
                .presentationDetents([.large])
        })
        .onAppear {
            self.recentCapsules = mockCapsules()
        }
    }
}

extension HomeView {
    private func title(_ localizedTitleKey : LocalizedStringKey) -> some View {
        Text(localizedTitleKey, comment: "Title")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.accent)
            .foregroundLinearGradient(colors: [.accentColor, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing)
    }
}

//MARK: - HomeView Recent Capsules
extension HomeView {
    private var highlightCapsulesView : some View {
        VStack(alignment: .leading, spacing: 0) {
            highlightsTitle
            
            horizontalScrollview
        }
    }
    
    private var highlightsTitle : some View {
        Text("highlights", comment: "Highlights:")
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(Color.defaultTextColor)
            .padding(.horizontal)
    }
    
    private var horizontalScrollview : some View {
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                ForEach(recentCapsules) { recentCapsule in
                    capsuleCardView(recentCapsule)
                }
            }
            .scrollTargetLayout()
        }
        .frame(height: 400)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.viewAligned)
    }
    
    private func capsuleCardView(_ recentCapsule : Capsule) -> some View {
        CapsuleCard(capsule: recentCapsule, showShadow: false)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                .ultraThinMaterial.shadow(.drop(color: .black.opacity(0.3), radius: 5)), in: RoundedRectangle(cornerRadius: 8)
            )
            .padding()
            .containerRelativeFrame(.horizontal, count: 1, spacing: 10)
            .scrollTransition { content, phase in
                content
                    .opacity(phase.isIdentity ? 1 : 0.3)
                    .scaleEffect(phase.isIdentity ? 1 : 0.3)
            }
    }
}

extension HomeView {
    private func mockCapsules() -> [Capsule] {
        let data = "image".data(using: .utf8)
        let data2 = "image2".data(using: .utf8)
        guard let data, let data2 else { return [] }
        let capsuleOne = Capsule(title: "Courtney & Jake Wedding", startDate: Date(), endDate: Date(), imagesData: [data, data])
        let capsuleTwo = Capsule(title: "Turkey Holiday", startDate: Date(), endDate: Date(), imagesData: [data2])
        let capsuleThree = Capsule(title: "Chester Night Out", startDate: Date(), endDate: Date(), imagesData: [])
        return [capsuleOne, capsuleTwo, capsuleThree]
    }
}

#Preview {
    ContentView()
}
