import SwiftUI


struct ContentView: View {
    @State private var showingGrid = true
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Group {
                    if showingGrid {
                        MissionsGridView(missions: missions, astronauts: astronauts)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 0.1).combined(with: .opacity),
                                removal: .scale(scale: 1.5).combined(with: .opacity)
                            ))
                    } else {
                        MissionsListView(missions: missions, astronauts: astronauts)
                            .transition(.asymmetric(
                                insertion: .scale(scale: 1.5).combined(with: .opacity),
                                removal: .scale(scale: 0.1).combined(with: .opacity)
                            ))
                    }
                }
                .animation(.interpolatingSpring(stiffness: 300, damping: 30), value: showingGrid)
                .toolbar {
                    Button("Show as \(showingGrid ? "list" : "grid")") {
                        showingGrid.toggle()
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
