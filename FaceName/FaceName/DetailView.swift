import MapKit
import SwiftUI

struct DetailView: View {
    var person: Person
    
    
    var body: some View {
        ScrollView {
            Text(person.name)
                .font(.largeTitle)
            person.image
                .resizable()
                .scaledToFit()
                
            Map(initialPosition: person.startPosition) {
                    Marker(person.name, coordinate: CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude ))
                }
                .frame(maxWidth: .infinity, minHeight: 300)
        }
    }
}

#Preview {
    DetailView(person: .example)
}
