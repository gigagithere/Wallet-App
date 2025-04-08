//
//  DetailView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 08/04/2025.
//

import SwiftUI

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
