import SwiftUI

struct AddActivityView: View {
    var activities: Activities
    @State private var title = ""
    @State private var description = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("Add new activity")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let activity = Activity(title: self.title, description: self.description)
                        activities.items.append(activity)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddActivityView(activities: Activities())
}
