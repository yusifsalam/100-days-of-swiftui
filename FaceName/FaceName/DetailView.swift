import SwiftUI

struct DetailView: View {
    var person: Person
    var body: some View {
        VStack {
            Text(person.name)
                .font(.largeTitle)
            person.image
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    DetailView(person: .example)
}
