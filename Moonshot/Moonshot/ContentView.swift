import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct ContentView: View {
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]
    
    var body: some View {
        NavigationStack {
            Button("Decode JSON") {
                let input = """
                {
                    "name": "Taylor Swift",
                    "address": {
                        "street": "555, Taylor Swift Avenue",
                        "city": "Nashville"
                    }
                }
                """

                let data = Data(input.utf8)
                let decoder = JSONDecoder()
                if let user = try? decoder.decode(User.self, from: data) {
                    print(user.address.street)
                }
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout) {
                    ForEach(0..<1000) {
                        Text("Item \($0)")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
