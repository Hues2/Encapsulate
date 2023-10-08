import SwiftUI

enum AppScreen : Codable, Hashable, Identifiable, CaseIterable {
    case home
    case favourites
    
    var id : AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label : some View {
        switch self {
        case .home:
            Label("Home", systemImage: "house.fill")
        case .favourites:
            Label("Favourites", systemImage: "heart.fill")
        }
    }
}

extension AppScreen {
    @ViewBuilder
    var destination : some View {
        switch self {
        case .home:
            HomeNavigationStack()
        case .favourites:
            FavouritesNavigationStack()
        }
    }
}
