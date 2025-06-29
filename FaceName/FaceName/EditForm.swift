import PhotosUI
import SwiftUI

struct EditForm: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Person) -> Void
    @State private var selectedItem: PhotosPickerItem?
    @State private var imageData: Data?
    @State private var processedImage: Image?
    @State private var name = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    PhotosPicker(selection: $selectedItem) {
                        if let processedImage {
                            processedImage
                                .resizable()
                                .scaledToFit()
                        } else {
                            ContentUnavailableView("No Picture", systemImage: "photo.badge.plus", description: Text("Import a photo to get started"))
                        }
                    }
                    .onChange(of: selectedItem, loadImage)
                }
                Section {
                    TextField("Name", text: $name)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let person = Person(name: name, photo: imageData!)
                        onSave(person)
                        dismiss()
                    }
                    .disabled(name == "" || processedImage == nil)
                }
            }
        }
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            self.imageData = imageData
            guard let inputImage = UIImage(data: imageData) else { return }
            
            processedImage = Image(uiImage: inputImage)
        }
    }
}

#Preview {
    func fakeOnSave(_ person: Person) {
        print("adding person")
    }
    return EditForm(onSave: fakeOnSave)
}
