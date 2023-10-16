import Foundation

struct TransferrableCapsule : Codable {
    let id : String
    let title : String
    let startDate : Date
    let endDate : Date
    var capsuleImages : [Data]
}
