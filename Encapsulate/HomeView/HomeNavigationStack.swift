import SwiftUI

struct HomeNavigationStack: View {
    @State private var homeNavigationPath = [HomePath]()
    var body: some View {
        NavigationStack(path: $homeNavigationPath) {
            HomeView()
        }
    }
}
