import Foundation
import SwiftUI

struct Person: Codable, Identifiable, Comparable {
    var id: UUID = UUID()
    let name: String
    let photo: Data
    
    var image: Image {
        let uiImage = UIImage(data: photo)!
        return Image(uiImage: uiImage)
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example: Person {
        let image = Image(systemName: "person")
        let imageData = ImageRenderer(content: image).uiImage?.pngData()
        return Person(name: "Test", photo: imageData!)
    }
}
