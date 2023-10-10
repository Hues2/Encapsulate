import SwiftUI
import PhotosUI
import SwiftData

struct AddCapsuleSheetView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context
    @State private var viewModel = AddCapsuleSheetViewModel()
    @Binding var showAddCapsuleSheet : Bool
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
                VStack(alignment: .leading, spacing: 25) {
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
    private func sheetTitle(_ localizedTitleKey : LocalizedStringKey) -> some View {
        Text(localizedTitleKey, comment: "Title")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(.accent)
            .foregroundLinearGradient(colors: [.accentColor, Color.secondAccentColor], startPoint: .leading, endPoint: .trailing)
    }
    
    private var sheetHeader : some View {
        VStack(spacing: 0) {
            HStack {
                sheetTitle("add_capsule")
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
    
    private func sectionTitle(_ titleKey : LocalizedStringKey, _ comment : StaticString) -> some View {
        Text(titleKey, comment: comment)
            .font(.body)
            .fontWeight(.light)
            .foregroundStyle(Color.defaultTextColor)
    }
}

//MARK: - Title Textfield
extension AddCapsuleSheetView {
    private var titleTextField : some View {
        VStack(alignment: .leading) {
            HStack {
                sectionTitle("add_capsule_title_label", "Title:")
                if viewModel.newCapsuleTitle.isEmpty {
                    Image(systemName: "xmark.app.fill")
                        .foregroundStyle(.red)
                } else {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(.green)
                }
            }
            
            TextField("",
                      text: $viewModel.newCapsuleTitle,
                      prompt:
                        Text("add_capsule_title_prompt", comment: "Capsule title")
                .foregroundStyle(Color.defaultTextColor)
                .font(.title3))
            .font(.title2)
            .foregroundStyle(Color.defaultTextColor)            
            .withMaterialCardModifier(.ultraThinMaterial)
            .scrollDismissesKeyboard(.interactively)
            .submitLabel(.done)
            .tint(colorScheme == .dark ? Color.secondAccentColor : .accentColor)
        }
    }
}

//MARK: - Date Pickers
extension AddCapsuleSheetView {
    private func datePicker(_ titleKey : LocalizedStringKey, _ date : Binding<Date>) -> some View {
        VStack(alignment: .leading) {
            sectionTitle(titleKey, "Date Title")
            
            DatePicker(selection: date, displayedComponents: .date) {
                Text("select:", comment: "Select:")
                    .font(.title3)
                    .fontWeight(.light)
            }
            .datePickerStyle(.compact)
            .foregroundStyle(Color.defaultTextColor)
            .withMaterialCardModifier(.ultraThinMaterial)
        }
    }
    
    private var startDatePicker : some View {
        datePicker("add_capsule_start_date", $viewModel.newCapsuleStartDate)
    }
    
    private var endDatePicker : some View {
        datePicker("add_capsule_end_date", $viewModel.newCapsuleEndDate)
    }
}

//MARK: - Photos Picker
extension AddCapsuleSheetView {
    private var photosPicker : some View {
        VStack(alignment: .leading) {
            HStack {
                sectionTitle("add_capsule_select_photos", "Select Photos")
                if viewModel.images.isEmpty {
                    Image(systemName: "xmark.app.fill")
                        .foregroundStyle(.red)
                } else {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(.green)
                }
            }
            
            picker
                .withMaterialCardModifier(.ultraThinMaterial)
        }
        
    }
    
    private var picker : some View {
        PhotosPicker(selection: $viewModel.photos, matching: .images) {
            Text("select", comment: "Select")
                .font(.title2)
                .fontWeight(.light)
                .foregroundStyle(Color.defaultTextColor)
        }
        .onChange(of: viewModel.photos) {
            Task {
                await viewModel.setImages()
                return
            }
        }
    }
    
    private var imagesView : some View {
        LazyVGrid(columns: columns) {
            ForEach(Array(zip(viewModel.images.indices, viewModel.images)), id: \.0) { (_, image) in
                image
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .frame(maxWidth: .infinity)
    }
}

//MARK: - Save Capsule Button
extension AddCapsuleSheetView {
    private var saveCapsuleButton : some View {
        Button {
            saveCapsule()
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.white)
            } else {
                Text("add_capsule_save_capsule_button", comment: "Save Capsule")
            }
        }
        .font(.title3)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .withCardModifier(colorScheme == .dark ? Color.accentColor : Color.secondAccentColor)
        .opacity(viewModel.canSaveCapsule() ? 1 : 0.3)
        .disabled(!viewModel.canSaveCapsule())
    }
}

extension AddCapsuleSheetView {
    private func saveCapsule() {
        // Set isSaving to true
        viewModel.isLoading = true
        // Insert the Capsule model into the context
        let newCapsule = Capsule(title: viewModel.newCapsuleTitle,
                                 startDate: viewModel.newCapsuleStartDate,
                                 endDate: viewModel.newCapsuleEndDate)
        context.insert(newCapsule)
        
        // Insert each of the CapsuleImages into the context
        for capsuleImage in viewModel.newCapsuleImages {
            context.insert(capsuleImage)
            
            // Set up the relationship between the new Capsule model and this CapsuleImage model
            capsuleImage.capsule = newCapsule
        }

        // Dismiss the sheet
        showAddCapsuleSheet = false
        // Set isSaving to false
        viewModel.isLoading = false
    }
}
