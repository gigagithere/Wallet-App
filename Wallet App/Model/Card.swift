//
//  Card.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI

struct User {
    var name: String
    var imageName: String? // np. nazwa assetu w katalogu Assets.xcassets
}

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var number: String
    var expires: String
    var color: Color
    var balance: Double
    var owner: User
    var cardImage: String
    
    var imageGeometryID: String {
        "VISA_\(id)"
    }
}

var cards: [Card] = [
    .init(
        number: "1233 3123 4124 1322",
        expires: "02/23",
        color: .blue,
        balance: 2323.94,
        owner: User(name: "John Doe"),
        cardImage: "unionpay"
    ),
    .init(
        number: "1234 5678 9012 3456",
        expires: "12/26",
        color: .red,
        balance: 874.21,
        owner: User(name: "John Doe"),
        cardImage: "americanexpress"
   
    ),
    .init(
        number: "9876 5432 1098 7654",
        expires: "06/25",
        color: .green,
        balance: 542.00,
        owner: User(name: "John Doe"),
        cardImage: "mastercard"
      
    ),
    .init(
        number: "1111 2222 3333 4444",
        expires: "09/24",
        color: .orange,
        balance: 1540.37,
        owner: User(name: "John Doe"),
        cardImage: "discover"
      
    ),
    .init(
        number: "0000 9999 8888 7777",
        expires: "01/27",
        color: .purple,
        balance: 450.12,
        owner: User(name: "John Doe"),
        cardImage: "visa"
  
    ),
    .init(
        number: "4444 3333 2222 1111",
        expires: "10/28",
        color: .gray,
        balance: 999.99,
        owner: User(name: "John Doe"),
        cardImage: "mastercard"
    )
]
