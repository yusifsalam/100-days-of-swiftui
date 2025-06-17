import SwiftUI

struct ShippingAddress: Codable {
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var isValid : Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }

        return true
    }
}

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _shippingAddress = "shippingAddress"
      
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var shippingAddress: ShippingAddress {
        didSet {
            if let encoded = try? JSONEncoder().encode(shippingAddress) {
                UserDefaults.standard.set(encoded, forKey: "shippingAddress")
            }
        }
    }
    
    var hasValidAddress: Bool {
        return shippingAddress.isValid
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    init() {
        if let shippingAddressData = UserDefaults.standard.data(forKey: "shippingAddress") {
            if let decodedShippingAddress = try? JSONDecoder().decode(ShippingAddress.self, from: shippingAddressData) {
                shippingAddress = decodedShippingAddress
                return
            }
        }
        shippingAddress = ShippingAddress()
    }
}
