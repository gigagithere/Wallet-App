//
//  Card.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI
import SwiftData

@Model
class Card: Identifiable {
    var id: String
    var number: String
    var expires: String
    var colorHex: String
    var balance: Double
    var ownerName: String
    var cardImage: String

    init(
        id: String = UUID().uuidString,
        number: String,
        expires: String,
        color: Color,
        balance: Double,
        ownerName: String,
        cardImage: String
    ) {
        self.id = id
        self.number = number
        self.expires = expires
        self.colorHex = color.toHex() ?? "#000000"
        self.balance = balance
        self.ownerName = ownerName
        self.cardImage = cardImage
    }

    var color: Color {
        Color(hex: colorHex) ?? .black
    }

    var imageGeometryID: String {
        "VISA_\(id)"
    }
}
