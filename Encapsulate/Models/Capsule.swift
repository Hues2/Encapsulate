import SwiftUI
import SwiftData

@Model
class Capsule : Identifiable {
    @Attribute(.unique) let id : String = UUID().uuidString
    var title : String
    var startDate : Date
    var endDate : Date
    @Relationship(deleteRule: .cascade, inverse: \CapsuleImage.capsule)
    var capsuleImages = [CapsuleImage]()
    
    init(title: String, startDate: Date, endDate: Date) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}

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
