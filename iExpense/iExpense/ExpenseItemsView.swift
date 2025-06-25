import SwiftData
import SwiftUI

struct ExpenseItemsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [ExpenseItem]
    
    init(type: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        _items = Query(filter: #Predicate<ExpenseItem> { item in
            type != "all" ? item.type == type: true
        }, sort: sortOrder)
    }
    
    var body: some View {
        List {
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
                .accessibilityLabel("Name: \(item.name), Type: \(item.type), Amount: \(item.amount)")
            }
            .onDelete(perform: removeItems)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let expenseItem = items[offset]
            modelContext.delete(expenseItem)
        }
    }
}

#Preview {
    ExpenseItemsView(type: "personal", sortOrder: [SortDescriptor(\ExpenseItem.amount)])
        .modelContainer(for: ExpenseItem.self)
}
