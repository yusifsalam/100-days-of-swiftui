import SwiftUI
import Observation
import SwiftData


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var navigationTitle = "iExpense"
    
    @State private var type = "all"
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount, order: .reverse),
        SortDescriptor(\ExpenseItem.type)
    ]
    
    
    var body: some View {
        NavigationStack {
            ExpenseItemsView(type: type, sortOrder: sortOrder)
                .navigationTitle($navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Menu("Type", systemImage: "line.3.horizontal.decrease.circle") {
                        Picker("Type", selection: $type) {
                            Text("All")
                                .tag("all")
                            Text("Personal")
                                .tag("Personal")
                            Text("Business")
                                .tag("Business")
                        }
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.type)
                                ])
                            
                            Text("Sort by amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount, order: .reverse),
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.type)
                                ])
                        }
                    }
                    
                    NavigationLink {
                        AddView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Label("Add expense", systemImage: "plus")
                    }
                    
                   
                }
        }
    }
    
    
}

#Preview {
    ContentView()
}
