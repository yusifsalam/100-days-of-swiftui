import SwiftUI
import Observation


struct ExpensesList: View {
    var items: [ExpenseItem]
    var onDelete: ([ExpenseItem]) -> Void
    
    var body: some View {
        ForEach(items) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }
                Spacer()
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .fontWeight(item.amount > 100 ? .black: item.amount > 10 ? .bold: .regular)
            }
        }
        .onDelete { offsets in
            let itemsToDelete = offsets.map { items[$0] }
            onDelete(itemsToDelete)
            
        }
        
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var navigationTitle = "iExpense"
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Business") {
                    ExpensesList(items: expenses.businessItems, onDelete: removeItems)
                }
                Section("Personal") {
                    ExpensesList(items: expenses.personalItems, onDelete: removeItems)
                }
                
            }
            .navigationTitle($navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                NavigationLink {
                    AddView(expenses: expenses)
                        .navigationBarBackButtonHidden()
                } label: {
                    Label("Add expense", systemImage: "plus")
                }
            }
        }
    }
    
    func removeItems(_ itemsToDelete: [ExpenseItem]) {
        expenses.items.removeAll { item in
            itemsToDelete.contains { $0.id == item.id }
        }
    }
}

#Preview {
    ContentView()
}
