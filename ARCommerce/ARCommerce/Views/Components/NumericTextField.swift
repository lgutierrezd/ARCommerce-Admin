//
//  NumericTextField.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 5/1/24.
//

import Combine
import SwiftUI

struct NumericTextField: View {
    var placeholder: String
    @Binding var value: Double
    
    var body: some View {
        let binding = Binding<String>(
            get: { String(value) },
            set: {
                if let newValue = Double($0) {
                    self.value = newValue
                }
            }
        )
        
        return TextField(placeholder, text: binding)
            .keyboardType(.numberPad)
            .onReceive(Just(binding.wrappedValue)) { newInput in
                let filtered = newInput.filter { "0123456789".contains($0) }
                if filtered != newInput {
                    binding.wrappedValue = filtered
                }
            }
            .padding()
    }
}

#Preview {
    NumericTextField(placeholder: "Enter price", value: .constant(1000))
        .fixedSize()
}
