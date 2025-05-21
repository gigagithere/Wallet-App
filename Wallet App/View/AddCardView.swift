//
//  AddCardView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 14/05/2025.
//

import SwiftUI
import SwiftData

struct AddCardView: View {
    @Environment(\.appThemeStyle) private var theme
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var modelContext
    var existingCard: Card? = nil
    
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var expires: String = ""
    @State private var balance: Double = 0.0
    @State private var color: Color = .blue
    @State private var selectedImage: String = "visa"
    
    @Namespace private var animation
    @State private var dummySelectedCard: Card? = nil
    @State private var dummyShowDetailView = false
    
    @Query private var profiles: [UserProfile]
    
    
    
    let availableImages = ["visa", "mastercard", "discover", "americanexpress", "unionpay"]
    
    var body: some View {
        NavigationView {
            ZStack {
                theme.backgroundGradient.ignoresSafeArea()
                // Live card preview
                VStack {
                    CardView(
                        card: Card(
                            number: number.isEmpty ? "---- ---- ---- ----" : number,
                            expires: expires.isEmpty ? "MM/YY" : expires,
                            color: color,
                            balance: balance,
                            ownerName: name,
                            cardImage: selectedImage
                        ),
                        showDetailView: $dummyShowDetailView,
                        selectedCard: $dummySelectedCard,
                        safeArea: EdgeInsets(),
                        animation: animation,
                        isPreview: true
                    )
                    .padding()
                    
                    Form {
                        Section(header: Text("Cardholder")) {
                            TextField("Full name", text: $name)
                        }
                        
                        Section(header: Text("Card details")) {
                            TextField("Card number", text: $number)
                                .keyboardType(.numberPad)
                                .onChange(of: number) { newValue, _ in
                                    let digits = newValue.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
                                    let trimmed = String(digits.prefix(16))
                                    let grouped = stride(from: 0, to: trimmed.count, by: 4).map {
                                        let start = trimmed.index(trimmed.startIndex, offsetBy: $0)
                                        let end = trimmed.index(start, offsetBy: min(4, trimmed.distance(from: start, to: trimmed.endIndex)))
                                        return String(trimmed[start..<end])
                                    }
                                    number = grouped.joined(separator: " ")
                                }
                            
                            TextField("Expiration date (MM/YY)", text: $expires)
                                .keyboardType(.numberPad)
                                .onChange(of: expires) { newValue, oldValue in
                                    let digits = newValue.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
                                    let trimmed = String(digits.prefix(4))
                                    if trimmed.count <= 2 {
                                        expires = trimmed
                                    } else {
                                        let prefix = trimmed.prefix(2)
                                        let suffix = trimmed.dropFirst(2)
                                        expires = "\(prefix)/\(suffix)"
                                    }
                                }
                            
                            TextField("Balance", value: $balance, format: .currency(code: "PLN"))
                                .keyboardType(.decimalPad)
                            
                            ColorPicker("Card color", selection: $color)
                            
                            Picker("Card brand", selection: $selectedImage) {
                                ForEach(availableImages, id: \.self) { imageName in
                                    Text(imageName.capitalized)
                                        .tag(imageName)
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("Add new card")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(existingCard == nil ? "Save" : "Update") {
                            let newCard = Card(
                                id: existingCard?.id ?? UUID().uuidString,
                                number: number,
                                expires: expires,
                                color: color,
                                balance: balance,
                                ownerName: name,
                                cardImage: selectedImage
                            )
                            
                            if let existing = existingCard {
                                existing.number = number
                                existing.expires = expires
                                existing.colorHex = color.toHex() ?? "#000000"
                                existing.balance = balance
                                existing.ownerName = name
                                existing.cardImage = selectedImage
                            } else {
                                modelContext.insert(newCard)
                            }
                            
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
                .onAppear {
                    if let card = existingCard {
                        name = card.ownerName
                        number = card.number
                        expires = card.expires
                        balance = card.balance
                        color = card.color
                        selectedImage = card.cardImage
                    } else if let profile = profiles.first {
                        name = profile.fullName
                        color = Color(hex: profile.defaultCardColorHex ?? "") ?? .blue
                    }
                }
            }
        }
        .foregroundColor(theme.textColor)
        .accentColor(theme.accentColor)
    }
}

#Preview {
    AddCardView()
        .modelContainer(for: Card.self)
}
