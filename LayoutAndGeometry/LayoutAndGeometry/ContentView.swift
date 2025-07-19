import SwiftUI


struct ContentView: View {
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        let hueShift = (proxy.frame(in: .global).minY / 800.0 + Double(index) * 0.05)
                            .truncatingRemainder(dividingBy: 1.0)
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color(hue: hueShift, saturation: 0.7, brightness: 0.9)
                            )
                            .opacity(min(1, (proxy.frame(in: .global).minY - 80 ) / 200.0))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(max(0.5, min(1.5, proxy.frame(in: .global).minY / 600.0 )))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
