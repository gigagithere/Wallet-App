//
//  Home.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI
import SwiftData

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State private var showDetailView: Bool = false
    @State private var selectedCard: Card?
    @State private var showAddCardSheet = false
    @State private var showProfileView = false
    @State private var cardToEdit: Card? = nil
    @Namespace private var animation
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var selectedBrand: String? = nil
    @Query private var allCards: [Card]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                Text("Wallet App")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            showProfileView = true
                        } label: {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .overlay(alignment: .leading) {
                        Button {
                            cardToEdit = nil
                            showAddCardSheet = true
                        } label: {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                let selectedIndex = allCards.firstIndex { card in
                    if let selectedCard = selectedCard {
                        return card.id == selectedCard.id
                    }
                    return false
                } ?? 0
                let mainOffset = CGFloat(selectedIndex) * -size.width
                
                LazyVStack(spacing: 10) {
                    ForEach(allCards) { card in
                        let cardOffset = CGFloat(allCards.firstIndex(where: { $0.id == card.id }) ?? 0) * size.width
                        CardView(
                            card: card,
                            showDetailView: $showDetailView,
                            selectedCard: $selectedCard,
                            safeArea: safeArea,
                            animation: animation,
                            onEdit: { selected in
                                cardToEdit = selected
                                showAddCardSheet = true
                            },
                            onDelete: { selected in
                                modelContext.delete(selected)
                            }
                        )
                        .frame(width: showDetailView ? size.width : nil)
                        .visualEffect { [showDetailView] content, proxy in
                            content
                                .offset(
                                    x: showDetailView ? cardOffset : 0,
                                    y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0
                                )
                        }
                    }
                }
                .padding(.top, 25)
                .offset(x: showDetailView ? mainOffset : 0)
            }
            .safeAreaPadding(15)
            .safeAreaPadding(.top, safeArea.top)
        }
        .scrollDisabled(showDetailView)
        .scrollIndicators(.hidden)
        .overlay {
            if let selectedCard, showDetailView {
                DetailView(selectedCard: selectedCard)
                    .padding(.top, expandedCardHeight)
                    .transition(.move(edge: .bottom))
            }
        }
        .sheet(isPresented: $showAddCardSheet) {
            AddCardView(existingCard: cardToEdit)
        }
        .sheet(isPresented: $showProfileView) {
            ProfileView()
        }
        
        var expandedCardHeight: CGFloat {
            safeArea.top + 130
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Card.self)
}
