//
//  UserProfile.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 14/05/2025.
//

import Foundation
import SwiftData

//swifdtatamoze nie wszedzie potrzbene jest

@Model
final class UserProfile {
    @Attribute var fullName: String
    @Attribute var email: String?
    @Attribute var phoneNumber: String?
    @Attribute var birthdate: Date?
    @Attribute var preferredCurrency: String?
    @Attribute var defaultCardColorHex: String?
    @Attribute var address: String?
    @Attribute var theme: String?
    
    init(fullName: String,
         email: String? = nil,
         phoneNumber: String? = nil,
         birthdate: Date? = nil,
         preferredCurrency: String? = nil,
         defaultCardColorHex: String? = nil,
         address: String? = nil,
         theme: String? = nil) {
        self.fullName = fullName
        self.email = email
        self.phoneNumber = phoneNumber
        self.birthdate = birthdate
        self.preferredCurrency = preferredCurrency
        self.defaultCardColorHex = defaultCardColorHex
        self.address = address
        self.theme = theme
    }
}

