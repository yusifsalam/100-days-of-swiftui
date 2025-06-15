import SwiftUI

struct ActivityView: View {
    var activityId: UUID
    var activities: Activities
    
    private var activity: Activity {
        activities.items.first(where: { $0.id == activityId }) ?? Activity(title: "", description: "")
    }
    
    var body: some View {
        VStack {
            Text(activity.title)
                .font(.title)
            Text(activity.description)
                .font(.subheadline)
            
            Form {
                
                Stepper {
                    Text("Value: \(activity.count)")
                } onIncrement: {
                    increment()
                } onDecrement: {
                    decrement()
                }
            }
        }
    }
    func increment() {
        var newActivity = activity
        newActivity.count += 1
        let index = activities.items.firstIndex(of: activity)!
        activities.items[index] = newActivity
    }
    
    func decrement() {
        guard activity.count > 0 else { return }
        var newActivity = activity
        newActivity.count -= 1
        let index = activities.items.firstIndex(of: activity)!
        activities.items[index] = newActivity
    }
}


#Preview {
    let activity = Activity(title: "Test", description: "Test activity")
    var activities = Activities()
    activities.items.append(activity)
    return ActivityView(activityId: activity.id, activities: activities)
}
