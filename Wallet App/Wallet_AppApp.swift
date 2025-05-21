//
//  Wallet_AppApp.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI

@main
struct Wallet_AppApp: App {
    
    @AppStorage("appTheme") private var appTheme: String = "system"
    
    var colorScheme: ColorScheme? {
        switch appTheme {
        case "light": return .light
        case "dark": return .dark
        default: return nil
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorScheme)
                .accentColor(AppThemeStyle.current.accentColor)
                .environment(\.appThemeStyle, AppThemeStyle.current) // <--- GLOBALNE
        }
        .modelContainer(for: [Card.self, UserProfile.self])
    }
}
