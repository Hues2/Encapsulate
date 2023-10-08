import SwiftUI
import Observation
import PhotosUI

@Observable
class AddCapsuleSheetViewModel {
    var newCapsule = Capsule(title: "",
                             startDate: Date(),
                             endDate: Date().plusOneDay() ?? Date(),
                             imagesData: [])
    var photos : [PhotosPickerItem] = []
    var images : [Image] = []
}

extension AddCapsuleSheetViewModel {
    func setImages() async {
        images.removeAll()
        
        for photo in photos {
            if let data = try? await photo.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    let image = Image(uiImage: uiImage)
                    images.append(image)
                    saveImageData(data)
                }
            }
        }
    }
    
    private func saveImageData(_ imageData : Data) {
        self.newCapsule.imagesData.append(imageData)
    }
}
