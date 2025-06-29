import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var sheetOpen = false
    
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.people.isEmpty {
                    ContentUnavailableView("No people yet", systemImage: "photo.badge.plus", description: Text("Import a photo to get started. "))
                } else {
                    ForEach(viewModel.people.sorted()) { person in
                        NavigationLink {
                            DetailView(person: person)
                        } label: {
                            
                            VStack(alignment: .leading) {
                                Text(person.name)
                                    .font(.title)
                                
                                person.image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 200)
                                    .padding()
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deletePerson)
                }
            }
            .navigationTitle("FaceName")
            .sheet(isPresented: $sheetOpen) {
                EditForm(onSave: viewModel.add)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Add person", systemImage: "plus") {
                        sheetOpen = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
