import SwiftUI
import SwiftData

@main
struct EncapsulateApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Capsule.self])
    }
}
