//
//  ContentView.swift
//  UnitConverter
//
//  Created by Ruvaid on 02/08/26.
//

import SwiftUI

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"

    var symbol: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "K"
        }
    }
}

struct ContentView: View {
    @State private var inputTemperature = 0.0
    @State private var inputUnit: TemperatureUnit = .celsius
    @State private var outputUnit: TemperatureUnit = .fahrenheit

    @FocusState private var inputIsFocused: Bool

    var convertedTemperature: Double {
        // Step 1: Convert the input temperature to the base unit (Celsius)
        let celsiusValue: Double

        switch inputUnit {
        case .celsius:
            celsiusValue = inputTemperature

        case .fahrenheit:
            celsiusValue = (inputTemperature - 32) * 5 / 9

        case .kelvin:
            celsiusValue = inputTemperature - 273.15
        }

        // Step 2: Convert from Celsius to the selected output unit
        switch outputUnit {
        case .celsius:
            return celsiusValue

        case .fahrenheit:
            return (celsiusValue * 9 / 5) + 32

        case .kelvin:
            return celsiusValue + 273.15
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    colors: [
                        Color.blue.opacity(0.7),
                        Color.purple.opacity(0.6),
                        Color.indigo.opacity(0.8)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                Form {
                    Section("Enter Temperature") {
                        TextField(
                            "Temperature",
                            value: $inputTemperature,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    }

                    Section("From") {
                        Picker("Input Unit", selection: $inputUnit) {
                            ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section("To") {
                        Picker("Output Unit", selection: $outputUnit) {
                            ForEach(TemperatureUnit.allCases, id: \.self) { unit in
                                Text(unit.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    Section("Converted Temperature") {
                        Text("\(convertedTemperature.formatted()) \(outputUnit.symbol)")
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Unit Converter")
                .toolbar {
                    if inputIsFocused {
                        Button("Done") {
                            inputIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
