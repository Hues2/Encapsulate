import Foundation
import UIKit
import SwiftUI

class Utils {
    private static func getTransferrableCapsule(_ capsule : Capsule) -> TransferrableCapsule {
        var capsuleImagesData = [Data]()
        for capsuleImage in capsule.capsuleImages {
            capsuleImagesData.append(capsuleImage.data)
        }
        return TransferrableCapsule(id: capsule.id, title: capsule.title, startDate: capsule.startDate, endDate: capsule.endDate, capsuleImages: capsuleImagesData)
    }
    
    static func getTransferrableJsonData(_ capsule : Capsule) -> Data? {
        let transferrableCapsule = getTransferrableCapsule(capsule)
        do {
            let jsonData = try JSONEncoder().encode(transferrableCapsule)
            print("JSONDATA created \(jsonData)")
            return nil
        } catch {
            print("Couldn't convert transferrable capsule into data")
            return nil
        }
    }
    
    static func getCapsuleImage(_ capsuleImage : CapsuleImage) -> Image? {
        guard let uiImage = UIImage(data: capsuleImage.data) else { return nil }
        return Image(uiImage: uiImage)
    }
}
