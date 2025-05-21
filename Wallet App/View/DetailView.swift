//
//  DetailView.swift
//  Wallet App
//
//  Created by Bartosz Mrugała on 08/04/2025.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.appThemeStyle) private var theme
    
    var selectedCard: Card
    
    @State private var expandedTransactionID: UUID?
    @State private var tappedTransactionID: UUID?
    
    @State private var transactions: [Transaction] = []
    
    var body: some View {
        ZStack {
            theme.backgroundGradient.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("Transactions")
                        .font(.title2.bold())
                        .padding()
                    
                    LazyVStack(spacing: 15) {
                        ForEach(transactions) { tx in
                            VStack(alignment: .leading) {
                                HStack(spacing: 10) {
                                    Image(tx.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(tx.name)
                                            .font(.headline)
                                        
                                        Text(tx.date, style: .date)
                                            .font(.caption2)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Text(String(format: "%@%.2f PLN", tx.amount < 0 ? "-" : "+", abs(tx.amount)))
                                        .foregroundColor(tx.amount < 0 ? .red : .green)
                                        .font(.headline)
                                    
                                    Image(systemName: "chevron.down")
                                        .rotationEffect(.degrees(expandedTransactionID == tx.id ? 180 : 0))
                                        .animation(.easeInOut(duration: 0.3), value: expandedTransactionID)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                
                                // Expanded content
                                if expandedTransactionID == tx.id {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Divider()
                                        Text("Phone: \(tx.phone)")
                                        Text("Reference: \(tx.referenceNumber)")
                                        Text("Type: \(tx.type)")
                                        Text("Full date: \(tx.date.formatted(date: .abbreviated, time: .shortened))")
                                        //                                        .font(.caption2)
                                    }
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.leading, 8)
                                    .transition(.opacity.combined(with: .move(edge: .top)))
                                }
                            }
                            .padding(10)
                            .background(.ultraThinMaterial) // systemowe, półprzezroczyste blur-tło
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: Color.gray.opacity(0.33), radius: 3)
                            .padding(.horizontal)
                            .scaleEffect(tappedTransactionID == tx.id ? 0.96 : 1)
                            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: tappedTransactionID)
                            .onTapGesture {
                                withAnimation {
                                    tappedTransactionID = tx.id
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    withAnimation {
                                        tappedTransactionID = nil
                                    }
                                }
                                withAnimation {
                                    if expandedTransactionID == tx.id {
                                        expandedTransactionID = nil
                                    } else {
                                        expandedTransactionID = tx.id
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        transactions = Transaction.mockData.shuffled()
                    }
                }
                .foregroundColor(theme.textColor)
                .accentColor(theme.accentColor)
            }
        }
    }
}

#Preview {
    DetailView(
        selectedCard: Card(
            number: "1234 5678 9012 3456",
            expires: "12/26",
            color: .blue,
            balance: 1234.56,
            ownerName: "John Doe",
            cardImage: "visa"
        )
    )
    .modelContainer(for: Card.self)
}
