//
//  Transaction.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 15/05/2025.
//

import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    let name: String
    let amount: Double
    let date: Date
    let imageName: String
    let phone: String
    let referenceNumber: String
    let type: String
}

extension Transaction {
    static let mockData: [Transaction] = [
        Transaction(name: "Esther Howard", amount: -65.89, date: Date().addingTimeInterval(-60*60*24*1), imageName: "face1", phone: "+48 123 456 789", referenceNumber: "TXN-001", type: "Sent"),
        Transaction(name: "Darkene Roberts", amount: 155.00, date: Date().addingTimeInterval(-60*60*24*2 - 3600), imageName: "face2", phone: "+48 987 654 321", referenceNumber: "TXN-002", type: "Received"),
        Transaction(name: "Eleanor Pena", amount: -102.87, date: Date().addingTimeInterval(-60*60*24*3 - 7200), imageName: "face3", phone: "+48 456 789 123", referenceNumber: "TXN-003", type: "Sent"),
        Transaction(name: "Wade Warren", amount: 75.50, date: Date().addingTimeInterval(-60*60*24*4 - 1800), imageName: "face4", phone: "+48 321 654 987", referenceNumber: "TXN-004", type: "Received"),
        Transaction(name: "Ronald Richards", amount: 30.00, date: Date().addingTimeInterval(-60*60*24*5), imageName: "face5", phone: "+48 555 000 111", referenceNumber: "TXN-005", type: "Sent"),
        Transaction(name: "Savannah Nguyen", amount: -45.20, date: Date().addingTimeInterval(-60*60*24*6 - 5400), imageName: "face6", phone: "+48 999 888 777", referenceNumber: "TXN-006", type: "Sent"),
        Transaction(name: "Jerome Bell", amount: 200.00, date: Date().addingTimeInterval(-60*60*24*7 - 2000), imageName: "face7", phone: "+48 112 233 445", referenceNumber: "TXN-007", type: "Received"),
        Transaction(name: "Courtney Henry", amount: -88.00, date: Date().addingTimeInterval(-60*60*24*8 - 1200), imageName: "face8", phone: "+48 223 344 556", referenceNumber: "TXN-008", type: "Sent"),
        Transaction(name: "Brooklyn Simmons", amount: 125.75, date: Date().addingTimeInterval(-60*60*24*9), imageName: "face9", phone: "+48 777 666 555", referenceNumber: "TXN-009", type: "Received"),
        Transaction(name: "Jenny Wilson", amount: -32.10, date: Date().addingTimeInterval(-60*60*24*10 - 1800), imageName: "face10", phone: "+48 888 777 666", referenceNumber: "TXN-010", type: "Sent"),
        Transaction(name: "Albert Flores", amount: 89.99, date: Date().addingTimeInterval(-60*60*24*11), imageName: "face11", phone: "+48 111 222 333", referenceNumber: "TXN-011", type: "Received"),
        Transaction(name: "Floyd Miles", amount: -29.49, date: Date().addingTimeInterval(-60*60*24*12 - 300), imageName: "face12", phone: "+48 444 333 222", referenceNumber: "TXN-012", type: "Sent"),
        Transaction(name: "Kristin Watson", amount: 310.00, date: Date().addingTimeInterval(-60*60*24*13 - 2000), imageName: "face13", phone: "+48 666 777 888", referenceNumber: "TXN-013", type: "Received"),
        Transaction(name: "Guy Hawkins", amount: -76.60, date: Date().addingTimeInterval(-60*60*24*14 - 4000), imageName: "face14", phone: "+48 333 111 999", referenceNumber: "TXN-014", type: "Sent"),
        Transaction(name: "Cody Fisher", amount: 95.10, date: Date().addingTimeInterval(-60*60*24*15), imageName: "face15", phone: "+48 121 212 121", referenceNumber: "TXN-015", type: "Received"),
        Transaction(name: "Jane Cooper", amount: -58.00, date: Date().addingTimeInterval(-60*60*24*16 - 1800), imageName: "face16", phone: "+48 232 323 232", referenceNumber: "TXN-016", type: "Sent"),
        Transaction(name: "Kathryn Murphy", amount: 110.50, date: Date().addingTimeInterval(-60*60*24*17 - 2400), imageName: "face17", phone: "+48 343 434 343", referenceNumber: "TXN-017", type: "Received"),
        Transaction(name: "Arlene McCoy", amount: -70.00, date: Date().addingTimeInterval(-60*60*24*18), imageName: "face18", phone: "+48 454 545 454", referenceNumber: "TXN-018", type: "Sent"),
        Transaction(name: "Jacob Jones", amount: 145.00, date: Date().addingTimeInterval(-60*60*24*19 - 1500), imageName: "face19", phone: "+48 565 656 565", referenceNumber: "TXN-019", type: "Received"),
        Transaction(name: "Annette Black", amount: -90.99, date: Date().addingTimeInterval(-60*60*24*20 - 3300), imageName: "face20", phone: "+48 676 767 676", referenceNumber: "TXN-020", type: "Sent")
    ]
}
