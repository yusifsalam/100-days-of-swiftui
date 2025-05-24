import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0
    @State private var questionNumber: Int = 1
    @State private var gameOver: Bool = false
    @State private var animationAmount = 0.0
    @State private var tappedFlagIndex = -1
    @State private var opacityAnimationAmount = 1.0
    @State private var scaleAnimationAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            tappedFlagIndex = number
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(tappedFlagIndex == number ? animationAmount: 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(tappedFlagIndex == number ? 1: 2 - opacityAnimationAmount)
                                .animation(.easeInOut(duration: 0.2), value: opacityAnimationAmount)
                                .scaleEffect(tappedFlagIndex == number ? 1 : scaleAnimationAmount)
                                
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Question #\(questionNumber)")
                    .foregroundStyle(.white)
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $gameOver) {
            Button("Restart", action: resetGame)
        } message : {
            Text("Your score was \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            animationAmount += 360
            scaleAnimationAmount -= 0.3
        }
        opacityAnimationAmount += 0.75
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        }
        else {
            scoreTitle = "Wrong, that's the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        if questionNumber >= 8 {
            gameOver = true
        } else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            questionNumber += 1
        }
        opacityAnimationAmount = 1.0
        scaleAnimationAmount = 1.0
    }
    
    func resetGame() {
        score = 0
        gameOver = false
        questionNumber = 1
    }
}

#Preview {
    ContentView()
}
