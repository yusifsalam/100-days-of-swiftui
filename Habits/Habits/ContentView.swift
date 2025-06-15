import SwiftUI

struct ActivitiesList: View {
    var items: [Activity]
    var activities: Activities
    var body: some View {
        ForEach(items) { item in
            NavigationLink {
                ActivityView(activityId: item.id, activities: activities)
            } label : {
                VStack {
                    Text(item.title)
                        .font(.headline)
                }
                Text("\(item.count)")
            }
    
        }
        .onDelete { offsets in
            activities.items.remove(atOffsets: offsets)
        }
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showAddActivityView = false
    
    var body: some View {
        NavigationStack {
            List {
                ActivitiesList(items: activities.items, activities: activities )
            }
            .navigationTitle("Habit tracker")
            .toolbar {
                Button("Add activity", systemImage: "plus") {
                    showAddActivityView = true
                }
            }
            .sheet(isPresented: $showAddActivityView) {
                AddActivityView(activities: activities)
            }
        }
    }
    
}

#Preview {
    ContentView()
}
