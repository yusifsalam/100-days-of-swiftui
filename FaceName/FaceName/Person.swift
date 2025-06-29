import CoreLocation
import MapKit
import SwiftUI

struct Person: Codable, Identifiable, Comparable {
    var id: UUID = UUID()
    let name: String
    let photo: Data
    let latitude: Double
    let longitude: Double
    
    var image: Image {
        let uiImage = UIImage(data: photo)!
        return Image(uiImage: uiImage)
    }
    
    var startPosition: MapCameraPosition {
        MapCameraPosition.region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
            )
        )
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example: Person {
        let image = Image(systemName: "person")
        let imageData = ImageRenderer(content: image).uiImage?.pngData()
        return Person(name: "Test", photo: imageData!, latitude: 60.17, longitude: 24.94)
    }
}
