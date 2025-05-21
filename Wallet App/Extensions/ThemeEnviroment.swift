//
//  ThemeEnviroment.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 15/05/2025.
//

import Foundation

import SwiftUI

private struct AppThemeStyleKey: EnvironmentKey {
    static let defaultValue: AppThemeStyle = .current
}

extension EnvironmentValues {
    var appThemeStyle: AppThemeStyle {
        get { self[AppThemeStyleKey.self] }
        set { self[AppThemeStyleKey.self] = newValue }
    }
}
