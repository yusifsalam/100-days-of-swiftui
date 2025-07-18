import SwiftUI

struct SortableProspectsView: View {
    let filter: FilterType
    @State private var sortOrder = [
        SortDescriptor(\Prospect.createdAt),
        SortDescriptor(\Prospect.name),
    ]
    
    var body: some View {
        NavigationStack {
            ProspectsView(filter: filter, sortOrder: sortOrder)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Sort by Name")
                                    .tag([
                                        SortDescriptor(\Prospect.name),
                                        SortDescriptor(\Prospect.createdAt),
                                    ])
                                
                                Text("Sort by Join Date")
                                    .tag([
                                        SortDescriptor(\Prospect.createdAt),
                                        SortDescriptor(\Prospect.name)
                                    ])
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    SortableProspectsView(filter: .none)
}
