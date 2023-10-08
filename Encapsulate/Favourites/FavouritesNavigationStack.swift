import SwiftUI

struct FavouritesNavigationStack: View {
    var body: some View {
        NavigationStack {
            FavouritesView()
                .background(Color.backgroundColor.ignoresSafeArea())
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
