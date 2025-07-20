import SwiftData
import SwiftUI


struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\DiceRoll.rolledAt, order: .reverse)]) var rolls: [DiceRoll]
    
    var total: Int {
        rolls.reduce(into: 0) { $0 += $1.value }
    }
    
    var average: Double {
        Double(total) / Double(rolls.count)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let latestRoll = rolls.first {
                    VStack {
                        Text("Latest Roll")
                            .font(.headline)
                        Text("\(latestRoll.value)")
                            .font(.largeTitle)
                    }
                    Button("Roll Dice 🎲") {
                        withAnimation {
                            rollDice()
                        }
                    }
                } else {
                    ContentUnavailableView {
                        Label("You have not rolled the dice yet!", systemImage: "dice")
                    } description: {
                        Text("Try your luck by rolling the dice")
                    } actions: {
                        Button("Roll your first dice") {
                            withAnimation {
                                rollDice()
                            }
                        }
                    }
                }
                
                List {
                    ForEach(rolls) { roll in
                        HStack {
                            Text("Value: \(roll.value)")
                                .font(.headline)
                            Text(roll.rolledAt.formatted(date: .abbreviated, time: .shortened))
                        }
                    }
                    .onDelete(perform: deleteRoll)
                }
                if !rolls.isEmpty {
                    
                    VStack {
                        Text("Rolls: \(rolls.count)")
                        Text("Total rolled: \(total)")
                        Text("Average rolled: \(average.formatted(.number.rounded(increment: 0.1)))")
                    }
                    .padding()
                }
            }
            .navigationTitle("Dice Roll")
        }
        
    }
    
    func rollDice() {
        let rolledNumber = Int.random(in: 1...6)
        modelContext.insert(DiceRoll(value: rolledNumber))
    }
    
    func deleteRoll(_ indexSet: IndexSet) {
        for index in indexSet {
            let roll = rolls[index]
            modelContext.delete(roll)
        }
    }
    
}

#Preview {
    ContentView()
}
