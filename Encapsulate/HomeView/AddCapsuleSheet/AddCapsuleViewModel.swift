import SwiftUI
import Observation
import PhotosUI
import Compression

@Observable
class AddCapsuleSheetViewModel {
    // New Capsule Values
    var newCapsuleTitle : String = ""
    var newCapsuleStartDate : Date = Date()
    var newCapsuleEndDate : Date = Date().plusOneDay() ?? Date()
    var newCapsuleImages = [CapsuleImage]()
    // Photos from PhotoPicker
    var photos = [PhotosPickerItem]()
    // Display Images
    var images = [Image]()
    // Save Button Saving State
    var isLoading : Bool = false
}

//MARK: - Capsule images functionality
extension AddCapsuleSheetViewModel {
    func setImages() async {
        images.removeAll()
        newCapsuleImages.removeAll()
        isLoading = true
        
        for photo in photos {
            if let data = try? await photo.loadTransferable(type: Data.self) {
                guard let uiImage = UIImage(data: data) else { continue }
                print("Data before compression \(data)")
                handleData(uiImage)
            }
        }
        isLoading = false
    }
    
    private func handleData(_ uiImage : UIImage) {
        let compressedData = uiImage.jpeg(.lowest)
        guard let compressedData else { return }
        print("Data after compression \(compressedData)")
        let image = Image(uiImage: uiImage)
        images.append(image) // Images that the UI displays
        createAndAddCapsuleImage(compressedData) // Create a CapsuleImage and add it to the list of capsuel images
    }
    
    private func createAndAddCapsuleImage(_ imageData : Data) {
        // When the images are first saved, they are by default, not favourites
        let capsuleImage = CapsuleImage(data: imageData, isFavourite: false)
        self.newCapsuleImages.append(capsuleImage)
    }
}

extension AddCapsuleSheetViewModel {    
    func canSaveCapsule() -> Bool {
        !(newCapsuleTitle.isEmpty) && !(newCapsuleImages.isEmpty) && !isLoading
    }
}
