import SwiftUI

struct NoCapsulesView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "camera.fill")
                .font(.title)
                .foregroundStyle(LinearGradient(colors: [.accent, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing))
            Text("no_saved_capsules", comment: "No Saved Capsules")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.defaultTextColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NoCapsulesView()
}
