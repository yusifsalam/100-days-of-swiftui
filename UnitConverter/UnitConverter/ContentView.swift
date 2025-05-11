import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var inputUnit = "minutes"
    @State private var outputUnit = "seconds"
    @State private var amount = 0.0
    
    let units = ["seconds", "minutes", "hours", "days", "weeks", "months", "years"]
    let conversionFactors = [1, 60, 60*60, 24*60*60, 7*24*60*60, 30*24*60*60, 365*24*60*60]
    

    var initialAmountInSeconds: Double {
        let index = units.firstIndex(of: inputUnit)!
        return Double(conversionFactors[index]) * amount
    }
    
    var outputAmount: Double {
        if amount == 0 { return 0 }
        let index = units.firstIndex(of: outputUnit)!
        let outputAmount = initialAmountInSeconds / Double(conversionFactors[index])
        return outputAmount
    }
    
   
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Value", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    
                }
                Section {
                    Picker("Output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Text("\(amount.formatted()) \(inputUnit) is equal to \(outputAmount.formatted()) \(outputUnit)")
                }
            }
            .navigationTitle("Time converter")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
