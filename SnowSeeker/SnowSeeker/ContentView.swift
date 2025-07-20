import SwiftUI

enum SortOrder {
    case undefined
    case name
    case country
}


struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOrder: SortOrder = .undefined
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var sortedFilteredResorts: [Resort] {
        switch sortOrder {
        case .undefined:
            filteredResorts
        case .name:
            filteredResorts.sorted(by: { $0.name < $1.name })
        case .country:
            filteredResorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(sortedFilteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                .rect(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Default").tag(SortOrder.undefined)
                            Text("Sort by Name").tag(SortOrder.name)
                            Text("Sort by Country").tag(SortOrder.country)
                                
                        }
                    }
                }
            }
            
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}


#Preview {
    ContentView()
}
