import Foundation
import SwiftUI

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var people: [Person]
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPeople")
        
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func add(_ person: Person) {
            people.append(person)
            save()
        }
        
        func deletePerson(at offsets: IndexSet ) {
            people.remove(atOffsets: offsets)
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
