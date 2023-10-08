import SwiftUI
import Observation
import PhotosUI

@Observable
class AddCapsuleSheetViewModel {
    var newCapsule = Capsule(title: "",
                             startDate: Date(),
                             endDate: Date().plusOneDay() ?? Date(),
                             capsuleImages: [])
    var photos = [PhotosPickerItem]()
    var images = [Image]()
    var capsuleImages = [CapsuleImage]()
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
        self.newCapsule.capsuleImages = capsuleImages
    }
    
    private func saveImageData(_ imageData : Data) {
        // When the images are first saved, they are by default, not favourites
        let capsuleImage = CapsuleImage(data: imageData, isFavourite: false)
        self.capsuleImages.append(capsuleImage)
    }
}
