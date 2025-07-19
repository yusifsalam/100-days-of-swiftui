import SwiftUI

extension View {
    func stacked(for card: Card, cards allCards: [Card]) -> some View {
        let position = allCards.firstIndex(of: card) ?? 0
        let total = allCards.count
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { isCorrect in
                            withAnimation {
                                removeCard(card: card, isCorrect: isCorrect)
                            }
                        }
                        .stacked(for: card, cards: cards)
                        .allowsHitTesting(card.id == cards.last?.id)
                        .accessibilityHidden(card.id != cards.last?.id)
//                        .allowsHitTesting(cards.firstIndex(of: card) == cards.count - 1)
//                        .accessibilityHidden(cards.firstIndex(of: card) < cards.count - 1)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
//            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
//                VStack {
//                    Spacer()
//                    
//                    HStack {
//                        Button {
//                            withAnimation {
//                                removeCard(at: cards.count - 1)
//                            }
//                        } label: {
//                            Image(systemName: "xmark.circle")
//                                .padding()
//                                .background(.black.opacity(0.7))
//                                .clipShape(.circle)
//                        }
//                        .accessibilityLabel("Wrong")
//                        .accessibilityHint("Mark your answer as being incorrect.")
//                        
//                        Spacer()
//                        
//                        Button {
//                            withAnimation {
//                                removeCard(at: cards.count - 1)
//                            }
//                        } label: {
//                            Image(systemName: "checkmark.circle")
//                                .padding()
//                                .background(.black.opacity(0.7))
//                                .clipShape(.circle)
//                        }
//                        .accessibilityLabel("Correct")
//                        .accessibilityHint("Mark your answer as being correct.")
//                    }
//                    .foregroundStyle(.white)
//                    .font(.largeTitle)
//                    .padding()
//                }
//            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: EditCards.init)
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }
    
    func removeCard(card: Card, isCorrect: Bool) {
        guard let index = getCardIndex(card) else { return }
        cards.remove(at: index)
        if !isCorrect {
            var cardToInsert = card
            cardToInsert.id = UUID()
            cards.insert(cardToInsert, at: 0)
        }
    }
    
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func getCardIndex(_ card: Card) -> Int? {
        return cards.lastIndex(where: { $0.id == card.id })
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    
    
}

#Preview {
    ContentView()
}
