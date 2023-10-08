import SwiftUI
import SwiftData

class Capsule : Identifiable {
    let id : UUID = UUID()
    var title : String
    var startDate : Date
    var endDate : Date
    var imagesData : [Data]
    
    init(title: String, startDate: Date, endDate: Date, imagesData: [Data]) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.imagesData = imagesData
    }
}
