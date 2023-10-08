import Foundation

extension Date {
    func plusOneDay() -> Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter.string(from: self)
    }
}
