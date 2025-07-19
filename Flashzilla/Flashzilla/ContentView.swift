import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(.rect)
                .onTapGesture {
                    print("Circle tapped!")
                }
        }
    }
}
#Preview {
    ContentView()
}
