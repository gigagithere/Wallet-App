//
//  AddCardView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 14/05/2025.
//

import SwiftUI
import SwiftData

struct AddCardView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var modelContext
    var existingCard: Card? = nil
    
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var expires: String = ""
    @State private var balance: String = ""
    @State private var color: Color = .blue
    @State private var selectedImage: String = "visa"
    
    @Namespace private var animation
    @State private var dummySelectedCard: Card? = nil
    @State private var dummyShowDetailView = false
    
    @Query private var profiles: [UserProfile]
    
    let availableImages = ["visa", "mastercard", "discover", "americanexpress", "unionpay"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Cardholder")) {
                    TextField("Full name", text: $name)
                }
                
                Section(header: Text("Card details")) {
                    TextField("Card number", text: $number)
                    TextField("Expiration date (MM/YY)", text: $expires)
                    TextField("Balance", text: $balance)
                        .keyboardType(.decimalPad)
                    
                    ColorPicker("Card color", selection: $color)
                    
                    Picker("Card brand", selection: $selectedImage) {
                        ForEach(availableImages, id: \.self) { imageName in
                            Text(imageName.capitalized)
                                .tag(imageName)
                        }
                    }
                }
                
                // Live card preview
                CardView(
                    card: Card(
                        number: number.isEmpty ? "---- ---- ---- ----" : number,
                        expires: expires.isEmpty ? "MM/YY" : expires,
                        color: color,
                        balance: Double(balance) ?? 0,
                        ownerName: name,
                        cardImage: selectedImage
                    ),
                    showDetailView: $dummyShowDetailView,
                    selectedCard: $dummySelectedCard,
                    safeArea: EdgeInsets(),
                    animation: animation,
                    isPreview: true
                )
                .padding(.bottom, 10)
            }
            .navigationTitle("Add new card")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(existingCard == nil ? "Save" : "Update") {
                        let newCard = Card(
                            id: existingCard?.id ?? UUID().uuidString,
                            number: number,
                            expires: expires,
                            color: color,
                            balance: Double(balance) ?? 0,
                            ownerName: name,
                            cardImage: selectedImage
                        )
                        
                        if let existing = existingCard {
                            existing.number = number
                            existing.expires = expires
                            existing.colorHex = color.toHex() ?? "#000000"
                            existing.balance = Double(balance) ?? 0
                            existing.ownerName = name
                            existing.cardImage = selectedImage
                        } else {
                            modelContext.insert(newCard)
                        }
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || number.isEmpty || expires.isEmpty || Double(balance) == nil)
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
                    balance = String(format: "%.2f", card.balance)
                    color = card.color
                    selectedImage = card.cardImage
                } else if let profile = profiles.first {
                    name = profile.fullName
                    color = Color(hex: profile.defaultCardColorHex ?? "") ?? .blue
                    // Możesz np. użyć preferredCurrency gdzie indziej
                }
            }
        }
    }
}

#Preview {
    AddCardView()
        .modelContainer(for: Card.self)
}
