import SwiftUI
import PhotosUI
import SwiftData

struct AddCapsuleSheetView: View {
    @Environment(\.modelContext) private var context
    @State private var viewModel = AddCapsuleSheetViewModel()
    @Binding var showAddCapsuleSheet : Bool
    private let columns = [GridItem(.flexible(minimum: 0, maximum: .infinity)),
                         GridItem(.flexible(minimum: 0, maximum: .infinity)),
                         GridItem(.flexible(minimum: 0, maximum: .infinity))]
    @State private var newCapsuleTitle : String = ""
    
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
                if viewModel.newCapsule.title.isEmpty {
                    Image(systemName: "xmark.app.fill")
                        .foregroundStyle(.red)
                } else {
                    Image(systemName: "checkmark.square.fill")
                        .foregroundStyle(.green)
                }
            }
            
            TextField("",
                      text: $viewModel.newCapsule.title,
                      prompt: Text("add_capsule_title_prompt", comment: "Capsule title")
                .foregroundStyle(Color.defaultTextColor))
                .font(.title2)
                .foregroundStyle(Color.white)
                .contentShape(RoundedRectangle(cornerRadius: 8))
                .withCardModifier(.accent)
                .scrollDismissesKeyboard(.interactively)
                .submitLabel(.done)
                .tint(.white)
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
            .foregroundStyle(.white)
            .withCardModifier(.accent)
        }
    }
    
    private var startDatePicker : some View {
        datePicker("add_capsule_start_date", $viewModel.newCapsule.startDate)
    }
    
    private var endDatePicker : some View {
        datePicker("add_capsule_end_date", $viewModel.newCapsule.endDate)
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
                .foregroundStyle(.white)
                .withCardModifier(.accent)
        }
        
    }
    
    private var picker : some View {
        PhotosPicker(selection: $viewModel.photos, matching: .images) {
            Text("select", comment: "Select")
                .font(.title2)
                .fontWeight(.light)
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
            showAddCapsuleSheet = false
        } label: {
            Text("add_capsule_save_capsule_button", comment: "Save Capsule")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .withCardModifier(Color.secondAccentColor)
                .opacity((viewModel.newCapsule.title.isEmpty || viewModel.images.isEmpty) ? 0.3 : 1)
        }
        .disabled(viewModel.newCapsule.title.isEmpty || viewModel.images.isEmpty)
    }
}

extension AddCapsuleSheetView {
    private func saveCapsule() {
        context.insert(viewModel.newCapsule)
    }
}

#Preview {
    ContentView()
}