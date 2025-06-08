import SwiftUI

struct DetailView: View {
    var number: Int
    
    var body: some View {
        Text("Detail view \(number)")
    }
    
    init(number: Int) {
        self.number = number
        print("Creating detail view \(number)")
    }
}

#Preview {
    DetailView(number: 1)
}
