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
