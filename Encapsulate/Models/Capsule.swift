import SwiftUI
import SwiftData

@Model
class Capsule : Identifiable {
    let id : UUID = UUID()
    var title : String
    var startDate : Date
    var endDate : Date
    var imagesData : [Data]
    
    func images() -> [Image] {
        var images = [Image]()
        for imageData in imagesData {
            guard let uiImage = UIImage(data: imageData) else { continue }
            images.append(Image(uiImage: uiImage))
        }
        return images
    }
    
    init(title: String, startDate: Date, endDate: Date, imagesData: [Data]) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.imagesData = imagesData
    }
}
