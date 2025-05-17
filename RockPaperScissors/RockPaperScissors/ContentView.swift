import SwiftUI

struct ContentView: View {
    @State private var currentChoice: Int = Int.random(in: 0..<3)
    @State private var playerShouldLose: Bool = Bool.random()
    @State private var round = 1
    @State private var score = 0
    @State private var lastRoundResult = ""
    @State private var gameOver = false
    private var tools = ["🪨", "📄", "✂️"]
    private var winningTools = ["📄", "✂️", "🪨"]
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                    .foregroundStyle(.primary)
                Text("Your goal is to \(playerShouldLose ? "lose": "win")")
                    .font(.title3)
                Text("Computer picks: \(tools[currentChoice])")
                    .font(.title2)
                HStack {
                    ForEach(tools, id: \.self) { tool in
                        Button(tool) {
                            checkResult(for: tool)
                        }
                        .font(.system(size: 90))
                        .padding()
                        .backgroundStyle(.ultraThinMaterial)
                    }
                }
                .padding()
                Text("\(lastRoundResult)")
                    .font(.headline)
                Spacer()
                Text("Round: \(round)")
                Text("Score: \(score)")
                    .font(.largeTitle)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .alert("Game over", isPresented: $gameOver) {
            Button("Reset game") {
                resetGame()
            }
        } message: {
            Text("Your score was: \(score)")
        }
    }
    
    func checkResult(for tool: String) {
        let playerChoice = tools.firstIndex(of: tool)!
        let playerIsBeatBy = winningTools[playerChoice]
        let computerChoice = tools[currentChoice]
        let playerLoses = computerChoice == playerIsBeatBy
        let challengeResult = playerChoice == currentChoice ? false : playerLoses == playerShouldLose
        if challengeResult == true {
            score += 1
            lastRoundResult = "Correct! You picked \(tool) against \(tools[currentChoice])"
        } else {
            score -= 1
            lastRoundResult = "Incorrect! You picked \(tool) against \(tools[currentChoice])"
        }
        round += 1
        currentChoice = Int.random(in: 0..<3)
        playerShouldLose = Bool.random()
        if round == 10 {
            gameOver = true
        }
    }
    
    func resetGame() {
        score = 0
        currentChoice = Int.random(in: 0..<3)
        playerShouldLose = Bool.random()
        round = 1
        lastRoundResult = ""
    }
}

#Preview {
    ContentView()
}
