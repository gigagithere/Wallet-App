//
//  CardImageView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 08/04/2025.
//

import SwiftUI
import SwiftData

struct CardImageView: View {
    let card: Card
    let id: String
    let height: CGFloat
    let animation: Namespace.ID

    var body: some View {
        Image(card.cardImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .matchedGeometryEffect(id: id, in: animation)
            .frame(height: height)
    }
}
#Preview {
    struct CardImageViewPreviewWrapper: View {
        @Namespace var ns

        var body: some View {
            CardImageView(
                card: Card(
                    number: "1234 5678 9012 3456",
                    expires: "12/26",
                    color: .blue,
                    balance: 1234.56,
                    ownerName: "John Doe",
                    cardImage: "visa"
                ),
                id: "VISA_PREVIEW",
                height: 40,
                animation: ns
            )
        }
    }

    return CardImageViewPreviewWrapper()
}
