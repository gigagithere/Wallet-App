//
//  ContentView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 31/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            GeometryReader {
                let size = $0.size
                let safeArea = $0.safeAreaInsets
                
                Home(size: size, safeArea: safeArea)
                    .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    ContentView()
}
