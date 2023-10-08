import SwiftUI

struct ContentView: View {
    @State private var selection : AppScreen? = .home
    
    var body: some View {
        AppTabView(selection: $selection)
    }
}
