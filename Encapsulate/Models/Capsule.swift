import SwiftUI
import SwiftData

@Model
class Capsule : Identifiable {
    @Attribute(.unique) let id : UUID = UUID()
    var title : String
    var startDate : Date
    var endDate : Date
    @Relationship(deleteRule: .cascade) var capsuleImages : [CapsuleImage]
    
    init(title: String, startDate: Date, endDate: Date, capsuleImages: [CapsuleImage]) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.capsuleImages = capsuleImages
    }
}

@Model
class CapsuleImage : Identifiable {
    @Attribute(.unique) var id : UUID = UUID()
    @Attribute(.externalStorage) var data : Data
    var isFavourite : Bool
        
    func image() -> Image? {
        guard let uiImage = UIImage(data: data) else { return nil }
        return Image(uiImage: uiImage)
    }
    
    init(data: Data, isFavourite: Bool) {
        self.data = data
        self.isFavourite = isFavourite
    }
}
