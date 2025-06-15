import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    let title: String
    let description: String
    var count: Int = 0
}

@Observable
class Activities {
    var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decoded = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decoded
                return
            }
        }
        
        items = []
    }
    
    
}
