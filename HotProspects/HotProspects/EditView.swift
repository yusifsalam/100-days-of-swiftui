import SwiftData
import SwiftUI

struct EditView: View {
    @Bindable var prospect: Prospect
    
    var body: some View {
        Form {
            TextField("Name", text: $prospect.name)
            TextField("Email", text: $prospect.emailAddress)
        }
        .navigationTitle("Edit prospect")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Prospect.self, configurations: config)
        let prospect = Prospect(name: "Teemu Teekkari", emailAddress: "hello@world.com", isContacted: false, createdAt: Date())
        return EditView(prospect: prospect)
            .modelContainer(container)
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
