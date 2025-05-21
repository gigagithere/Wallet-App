//
//  File.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 15/05/2025.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case system, pastel, darkNeon, minimal, sandstone, sunset, oliveGarden

    var id: String { self.rawValue }

    static func current() -> AppThemeStyle {
        let selected = UserDefaults.standard.string(forKey: "appTheme") ?? "system"
        return AppTheme(rawValue: selected)?.style ?? .system
    }

    var style: AppThemeStyle {
        switch self {
        case .system:
            return .system

        case .pastel:
            return .init(
                backgroundColor: Color(red: 0.96, green: 0.94, blue: 0.98), // Jasny liliowy
                textColor: Color(red: 0.25, green: 0.20, blue: 0.40),       // Głęboki fiolet
                accentColor: Color(red: 0.55, green: 0.36, blue: 0.89)      // Fioletowy akcent
            )

        case .darkNeon:
            return .init(
                backgroundColor: Color(red: 0.54, green: 0.04, blue: 0.08),   // niemal czarny z lekkim niebieskim
                textColor: Color(red: 0.85, green: 0.95, blue: 1.0),          // bardzo jasny błękit
                accentColor: Color(red: 1.0, green: 0.2, blue: 0.6)           // neonowy róż (widoczny)
            )

        case .minimal:
            return .init(
                backgroundColor: Color(.systemGray6),
                textColor: Color(.label),
                accentColor: .red
            )
            
        case .sandstone:
            return .init(
                backgroundColor: Color(hex: "#F2F2F2") ?? .white,
                textColor: Color(hex: "#B6B09F") ?? .gray,
                accentColor: Color(hex: "#EAE4D5") ?? .pink
            )
        case .sunset:
                    return .init(
                        backgroundColor: Color(hex: "#FAEDCA") ?? .white,      // bardzo jasny beż
                        textColor: Color(hex: "#FE5D26") ?? .gray,             // zieleń pastelowa
                        accentColor: Color(hex: "#F2C078") ?? .orange
                    )
            
        case .oliveGarden:
            return .init(
                backgroundColor: Color(hex: "#D2D0A0") ?? .white,   // delikatny beż / zgaszony piaskowy
                textColor: Color(hex: "#537D5D") ?? .black,         // ciemna oliwka (najbardziej kontrastowy kolor)
                accentColor: Color(hex: "C1DBB3") ?? .green        // jasna zieleń – przycisk / podkreślenia
            )
        }
    }
}

struct AppThemeStyle {
    var backgroundColor: Color
    var textColor: Color
    var accentColor: Color
    var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [backgroundColor, backgroundColor.opacity(0.5)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    static let system = AppThemeStyle(
        backgroundColor: Color(.systemBackground),
        textColor: Color(.label),
        accentColor: Color.accentColor
    )
}

extension AppThemeStyle {
    static var current: AppThemeStyle {
        AppTheme(rawValue: UserDefaults.standard.string(forKey: "appTheme") ?? "system")?.style ?? .system
    }
}

