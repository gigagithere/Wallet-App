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
                        let cardOffset = CGFloat(cards.firstIndex(where: { $0.id == card.id }) ?? 0) * size.width
                            CardView(card: card, showDetailView: $showDetailView, selectedCard: $selectedCard, animation: animation)
                            .frame(width: showDetailView ? size.width : nil)
                            .visualEffect { content, proxy in
                                content
                                    .offset(x: showDetailView ? cardOffset : 0, y: showDetailView ? -proxy.frame(in: .global).minY : 0)
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
}
#Preview {
    ContentView()
}
