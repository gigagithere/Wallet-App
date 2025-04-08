//
//  CardImageView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 08/04/2025.
//

import SwiftUI

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
