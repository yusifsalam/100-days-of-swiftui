import LocalAuthentication
import MapKit
import SwiftUI


struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var mapStyle: MapStyle = .standard
    @State private var showAuthFailed = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    var body: some View {
        ZStack {
            if viewModel.authState == .unlocked {
                VStack {
                    MapReader { proxy in
                        Map(initialPosition: startPosition) {
                            ForEach(viewModel.locations) { location in
                                Annotation(location.name, coordinate: location.coordinate) {
                                    Image(systemName: "star.circle")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(.circle)
                                        .onTapGesture {
                                            viewModel.selectedPlace = location
                                        }
                                }
                            }
                        }
                        .mapStyle(mapStyle)
                        .onTapGesture { position in
                            if let coordinate = proxy.convert(position, from: .local) {
                                viewModel.addLocation(at: coordinate)
                            }
                        }
                        .sheet(item: $viewModel.selectedPlace) { place in
                            EditView(location: place) {
                                viewModel.update(location: $0)
                            }
                        }
                    }
                    HStack {
                        Button("Standard") {
                            mapStyle = .standard
                        }
                        Button("Hybrid") {
                            mapStyle = .hybrid
                        }
                    }
                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Authentication failed", isPresented: $showAuthFailed) {
            Button("OK") {
                showAuthFailed = false
            }
        }
        .onChange(of: viewModel.authState) { newState in
            if newState == .failed {
                showAuthFailed = true
            }
        }
    }
        
    
}


#Preview {
    ContentView()
}

