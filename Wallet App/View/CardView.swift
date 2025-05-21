//
//  Home.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI
import SwiftData

struct CardView: View {
    let card: Card
    @Binding var showDetailView: Bool
    @Binding var selectedCard: Card?
    let safeArea: EdgeInsets
    let animation: Namespace.ID
    @State private var showContextMenu = false
    var isPreview: Bool = false
    var onEdit: ((Card) -> Void)? = nil
    var onDelete: ((Card) -> Void)? = nil
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(card.color.gradient)

            VStack(alignment: .leading, spacing: 15) {
                if !showDetailView {
                    CardImageView(
                        card: card,
                        id: card.imageGeometryID,
                        height: 20,
                        animation: animation
                    )
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(card.number)
                        .font(.caption)
                        .foregroundStyle(.white.secondary)

                    Text(
                        card.balance,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: showDetailView ? .center : .leading
                )
                .overlay {
                    ZStack {
                        if showDetailView && !isPreview {
                            CardImageView(
                                card: card,
                                id: card.imageGeometryID,
                                height: 20,
                                animation: animation
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: 35)
                        }

                        if let selected = selectedCard, selected.id == card.id, showDetailView, !isPreview {
                            Button {
                                withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                                    selectedCard = nil
                                    showDetailView = false
                                }
                            } label: {
                                Image(systemName: "chevron.left")
                                    .font(.title3.bold())
                                    .foregroundStyle(.white)
                                    .contentShape(.rect)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: -20)
                            .transition(.asymmetric(insertion: .opacity, removal: .identity))
                        }
                    }
                }
                .padding(.top, (showDetailView  && !isPreview) ? safeArea.top - 10 : 0)

                HStack {
                    Text("Expires " + card.expires)
                        .font(.caption)
                    Spacer()
                    Text(card.ownerName)
                        .font(.callout)
                }
                .foregroundStyle(.white.secondary)
            }
            .padding(showDetailView ? 15 : 25)
        }
        .frame(
            height: showDetailView ? safeArea.top + 130 : 200,
            alignment: .top
        )
        .clipShape(
            RoundedRectangle(cornerRadius: showDetailView ? 0 : 25)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 4)
        .onTapGesture {
            guard !showDetailView, !isPreview else { return }
            withAnimation(.smooth(duration: 0.5, extraBounce: 0)) {
                selectedCard = card
                showDetailView = true
            }
        }
        .onLongPressGesture {
            showContextMenu = true
        }
        .confirmationDialog("Choose an action", isPresented: $showContextMenu, titleVisibility: .visible) {
            Button("Edit", role: .none) {
                onEdit?(card)
            }
            Button("Delete", role: .destructive) {
                onDelete?(card)
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var show = false
        @State private var selected: Card? = nil
        @Namespace private var ns

        var body: some View {
            CardView(
                card: Card(
                    number: "1234 5678 9012 3456",
                    expires: "12/26",
                    color: .blue,
                    balance: 1234.56,
                    ownerName: "John Doe",
                    cardImage: "visa"
                ),
                showDetailView: $show,
                selectedCard: $selected,
                safeArea: EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0),
                animation: ns,
                isPreview: false
            )
        }
    }

    return PreviewWrapper()
}
