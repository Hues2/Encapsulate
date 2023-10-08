import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var capsules : [Capsule]
    @State private var showAddCapsuleSheet : Bool = false
    
    var body: some View {
        VStack {
            if capsules.isEmpty {
                NoCapsulesView()
            } else {
                capsulesHomeView
            }
        }
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
        .sheet(isPresented: $showAddCapsuleSheet) {
            AddCapsuleSheetView(showAddCapsuleSheet: $showAddCapsuleSheet)
                .presentationDetents([.large])
        }
    }
}

extension HomeView {
    private func title(_ localizedTitleKey : LocalizedStringKey) -> some View {
        Text(localizedTitleKey, comment: "Title")
            .font(.title)
            .fontWeight(.black)
            .foregroundStyle(.accent)
            .foregroundLinearGradient(colors: [.accentColor, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing)
    }
    
    private var capsulesHomeView : some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    HighlightCapsulesView(capsules: capsules, proxy: proxy)
                        .padding(.vertical, 20)
                    
                    CapsulesView(capsules: capsules, proxy: proxy)
                        .padding(.bottom)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}
