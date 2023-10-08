import SwiftUI
import PhotosUI

struct AddCapsuleSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var showAddCapsuleSheet : Bool
    @State var newCapsule : Capsule = Capsule(title: "",
                                              startDate: Date(),
                                              endDate: Date(),
                                              imagesData: [])
    @State private var photos : [PhotosPickerItem] = []
    @State private var images : [Image] = []
    private let columns = [GridItem(.flexible(minimum: 0, maximum: .infinity)),
                         GridItem(.flexible(minimum: 0, maximum: .infinity)),
                         GridItem(.flexible(minimum: 0, maximum: .infinity))]
    
    var body: some View {
        addCapsuleSheet
    }
}

//MARK: - Sheet View
extension AddCapsuleSheetView {
    private var addCapsuleSheet : some View {
        VStack(spacing: 0) {
            sheetHeader
            ScrollView {
                VStack(alignment: .leading, spacing: 30) {
                    titleTextField
                    
                    startDatePicker
                    
                    endDatePicker
                    
                    photosPicker
                    
                    imagesView
                    
                    saveCapsuleButton
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundColor)
    }
}

//MARK: - Sheet Header
extension AddCapsuleSheetView {
    private func title(_ localizedTitleKey : LocalizedStringKey) -> some View {
        Text(localizedTitleKey, comment: "Title")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.accent)
            .foregroundLinearGradient(colors: [.accentColor, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing)
    }
    
    private var sheetHeader : some View {
        VStack(spacing: 0) {
            HStack {
                title("add_capsule")
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                Button {
                    withAnimation {
                        self.showAddCapsuleSheet = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            Divider()
        }
    }
}

//MARK: - Title Textfield
extension AddCapsuleSheetView {
    private var titleTextField : some View {
        VStack(alignment: .leading) {
            Text("add_capsule_title_label")
                .font(.title3)
                .fontWeight(.black)
            TextField("",
                      text: $newCapsule.title,
                      prompt: Text("add_capsule_title_prompt", comment: "Capsule title")
                .foregroundStyle(Color.defaultTextColor))
                .font(.title2)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            Color.accentColor
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
}

//MARK: - Date Pickers
extension AddCapsuleSheetView {
    private func datePicker(_ titleKey : LocalizedStringKey, _ date : Binding<Date>) -> some View {
        VStack(alignment: .leading) {
            DatePicker(selection: date) {
                Text(titleKey, comment: "Date Title")
                    .font(.title3)
                    .fontWeight(.black)
            }
            .datePickerStyle(.compact)
        }
        .foregroundStyle(.white)
        .padding()
        .background(
            Color.accentColor
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
    
    private var startDatePicker : some View {
        datePicker("add_capsule_start_date", $newCapsule.startDate)
    }
    
    private var endDatePicker : some View {
        datePicker("add_capsule_end_date", $newCapsule.endDate)
    }
}

//MARK: - Photos Picker
extension AddCapsuleSheetView {
    private var photosPicker : some View {
        HStack {
            Text("add_capsule_select_photos", comment: "Select Photos")
                .font(.title3)
                .fontWeight(.black)
            Spacer()
            picker
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            Color.accentColor
                .clipShape(RoundedRectangle(cornerRadius: 8))
        )
    }
    
    private var picker : some View {
        PhotosPicker("Select photos", selection: $photos, matching: .images)
            .onChange(of: self.photos) {
                Task {
                    images.removeAll()
                    
                    for photo in photos {
                        if let data = try? await photo.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                let image = Image(uiImage: uiImage)
                                self.images.append(image)
                            }
                        }
                    }
                    return
                }
            }
    }
    
    private var imagesView : some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(zip(self.images.indices, self.images)), id: \.0) { (_, image) in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension AddCapsuleSheetView {
    private var saveCapsuleButton : some View {
        // TODO: Only make button tappable if all fields are valid
        Button {
            // TODO: Save capsule to Swift Data
        } label: {
            Text("add_capsule_save_capsule_button", comment: "Save Capsule")
                .font(.title)
                .fontWeight(.black)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }

    }
}

#Preview {
    ContentView()
}
