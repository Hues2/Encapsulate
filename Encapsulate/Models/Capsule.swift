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
