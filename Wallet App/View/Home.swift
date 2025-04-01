//
//  Home.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    @State private var showDetailView: Bool = false
    @State private var selectedCard: Card?
    @Namespace private var animation
    
    var body: some View {
        /// ScrollView with Cards UI
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                Text("My Wallet")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .trailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "person")
                                .resizable()
                                .scaledToFit()
                            
                        }
                    }
                    .blur(radius: showDetailView ? 5 : 0)
                    .opacity(showDetailView ? 0 : 1)
                
                /// Cards View
                let mainOffset = CGFloat(cards.firstIndex(where: { $0.id == selectedCard?.id }) ?? 0) * -size.width
                LazyVStack(spacing: 10) {
                    ForEach(cards) { card in
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * size.width;     CardView(card: card, showDetailView: $showDetailView, selectedCard: $selectedCard, animation: animation)
                            .frame(width: showDetailView ? size.width : nil)
                            .visualEffect { [showDetailView] content, proxy in
                                content
                                    .offset(x: showDetailView ? cardOffset : 0, y: showDetailView ? -proxy.frame(in: .scrollView).minY : 0)
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
                    .padding(.top, 160)
                    .transition(.move(edge: .bottom))
            }
        }
    }
    
    /// Card View
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
}
    /// Card Image View
    struct CardImageView: View {
        let card: Card
        var animation: Namespace.ID
        
        var body: some View {
            Image(card.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: card.id, in: animation)
                .frame(width: 70, height: 50)
        }
    }

struct DetailView: View {
var selectedCard: Card
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 12) {
                ForEach(1...20, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 15)
                        .fill(.gray.gradient)
                        .frame(height: 45)
                }
            }
            .padding(15)
        }
    }
}
    
#Preview {
    ContentView()
}
