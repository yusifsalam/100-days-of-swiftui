import PhotosUI
import SwiftUI
import StoreKit


struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    
    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    var body: some View {
        
        VStack {
            let example = Image(.example)

            ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
                Label("Click to share", systemImage: "airplane")
            }
            Button("Leave a review") {
                requestReview()
            }

            PhotosPicker(selection: $pickerItem, matching: .images) {
                Label("Select a picture", systemImage: "photo")
            }
            selectedImage?
                .resizable()
                .scaledToFit()
        }
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
