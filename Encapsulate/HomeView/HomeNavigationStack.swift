import SwiftUI

struct HomeNavigationStack: View {
    var body: some View {
        NavigationStack {
            HomeView()
                .background(Color.backgroundColor.ignoresSafeArea())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
