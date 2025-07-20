import Foundation
import SwiftData

@Model
class DiceRoll {
    var value: Int
    var rolledAt: Date
    
    init(value: Int) {
        self.value = value
        self.rolledAt = Date()
    }
    
}
