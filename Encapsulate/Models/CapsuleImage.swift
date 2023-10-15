import SwiftUI
import SwiftData

@Model
class CapsuleImage : Identifiable {
    @Attribute(.externalStorage) var data : Data
    var isFavourite : Bool
    var capsule : Capsule?
        
    func image() -> Image? {
        guard let uiImage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiImage)
    }
    
    init(data: Data, isFavourite: Bool) {
        self.data = data
        self.isFavourite = isFavourite
    }
}
