//
//  Color.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 15/05/2025.
//

import SwiftUI

extension Color {
    init?(hex: String) {
        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hex.hasPrefix("#") {
            hex.removeFirst()
        }

        guard hex.count == 6, let int = UInt64(hex, radix: 16) else {
            return nil
        }

        let r = Double((int >> 16) & 0xFF) / 255.0
        let g = Double((int >> 8) & 0xFF) / 255.0
        let b = Double(int & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }

    func toHex() -> String? {
        let uiColor = UIColor(self)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil) else {
            return nil
        }
        return String(format: "#%02X%02X%02X", Int(red*255), Int(green*255), Int(blue*255))
    }
}
