import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .offset(x: 100, y: 100)
            .background(.red)

    }
}
#Preview {
    ContentView()
}
