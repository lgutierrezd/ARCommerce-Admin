//
//  Color+.swift
//  ARCommerce
//
//  Created by Luis Gutierrez on 3/1/24.
//

import SwiftUI

extension Color {
    func toHex() -> String {
        guard let components = cgColor?.components else { return "" }

        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)

        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}
