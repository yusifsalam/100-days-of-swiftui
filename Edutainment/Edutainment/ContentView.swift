import SwiftUI

struct Question {
    var text: String
    var answer: Int
}

struct ContentView: View {
    @State private var gameStarted = false
    @State private var gameOver = false
    @State private var questionCountIndex = 0
    @State private var questionNumber = 1
    @State private var questions: [Question] = []
    @State private var score = 0
    @State private var currentAnswer: Int?
    private var currentQuestion: Question {
        questions[questionNumber - 1]
    }
    private var questionCountOptions = [5,10,20]
    var body: some View {
        if !gameStarted {
            VStack {
                Text("How many practice questions would you like to answer?")
                    .font(.title2)
                Stepper("Questions", value: $questionCountIndex, in: 0...2)
                Text("Question count: \(questionCountOptions[questionCountIndex])")
                Button("Start game") {
                    startGame()
                }.buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
        } else {
            if gameOver {
                Text("Game over!")
                    .font(.headline)
                Text("Your score: \(score)")
                    .font(.subheadline)
                Button("Play again") {
                    resetGame()
                }
                .buttonStyle(.borderedProminent)
                
            } else {
                VStack {
                    Spacer()
                    Text("Your score: \(score)")
                        .font(.title2)
                    Text("Question number \(questionNumber)")
                    Text(currentQuestion.text)
                        .font(.largeTitle)
                    
                    TextField("Your answer", value: $currentAnswer, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                    Button("Check answer") {
                        checkAnswer()
                    }
                    .disabled(currentAnswer == nil)
                    .buttonStyle(.borderedProminent)
                    Spacer()
                }
            }
        }
    }
    
    func generateQuestions() {
        var newQuestions: [Question] = []
        for _ in 0..<questionCountOptions[questionCountIndex] {
            let randomNumber1 = Int.random(in: 1...12)
            let randomNumber2 = Int.random(in: 1...12)
            let correctAnswer = randomNumber1 * randomNumber2
            let newQuestion = Question(text: "\(randomNumber1) * \(randomNumber2) = ?", answer: correctAnswer)
            newQuestions.append(newQuestion)
        }
        questions = newQuestions
    }
    
    func startGame() {
        generateQuestions()
        gameStarted = true
    }
    
    func resetGame() {
        gameStarted = false
        gameOver = false
        generateQuestions()
        score = 0
        questionNumber = 1
    }
    
    func checkAnswer() {
        if currentAnswer == currentQuestion.answer {
            score += 1
        }
        if questionNumber + 1 > questionCountOptions[questionCountIndex] {
            gameOver = true
        }
        questionNumber += 1
        currentAnswer = nil
    }
}

#Preview {
    ContentView()
}
