//
//  CardView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 08/04/2025.
//

import SwiftUI

 struct CardView: View {
        let card: Card
        @Binding var showDetailView: Bool
        @Binding var selectedCard: Card?
        var animation: Namespace.ID
        
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(card.color.gradient)
                
                VStack(alignment: .leading, spacing: 15) {
                    // Jedno wywołanie CardImageView – nie duplikujemy go
                    CardImageView(card: card, animation: animation)
                        .offset(y: showDetailView ? 70 : 0)
                    
                    VStack(alignment: .center, spacing: 4) {
                        Text(card.number)
                            .font(.caption)
                            .foregroundStyle(.white.secondary)
                        
                        Text("$ \(card.balance, specifier: "%.2f")")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity,
                           alignment: showDetailView ? .center : .leading)
                    .overlay {
                        // Overlay pozostawia tylko przycisk powrotu, gdy widok szczegółowy jest aktywny
                        if let selectedCard, selectedCard.id == card.id, showDetailView {
                            Button {
                                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                    self.selectedCard = nil
                                    showDetailView = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .contentShape(Rectangle())
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                            .offset(y: -45)
                        }
                    }
                    
                    HStack {
                        Text("Expires: \(card.expires)")
                            .font(.caption)
                        
                        Spacer()
                        
                        Text(card.owner.name)
                            .font(.callout)
                    }
                    .foregroundStyle(.white.secondary)
                }
                .padding(25)
            }
            .frame(height: showDetailView ? 160 : 220)
            .clipShape(RoundedRectangle(cornerRadius: showDetailView ? 0 : 25))
            .onTapGesture {
                guard !showDetailView else { return }
                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                    selectedCard = card
                    showDetailView = true
                }
            }
        }
    }
#Preview {
    @Previewable @State var showDetailView = false
    @Previewable @State var selectedCard: Card? = nil
    @Previewable @Namespace var animation

    CardView(
        card: Card(
            number: "1233 3123 4124 1322",
            expires: "02/23",
            color: .blue,
            balance: 2323.94,
            owner: User(name: "John Doe"),
            cardImage: "unionpay"
        ),
        showDetailView: $showDetailView,
        selectedCard: $selectedCard,
        animation: animation
    )
}
