//
//  HistoryCardView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 29/11/21.
//

import SwiftUI

struct HistoryCardView: View {
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 8) {
                Text("Pedido de socorro")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AsyncImage(withURL: "https://firebasestorage.googleapis.com/v0/b/sos-health-app.appspot.com/o/Captura%20de%20Tela%202021-11-29%20a%CC%80s%2020.38.21.png?alt=media&token=63c3941b-9654-4099-8ea9-2d2d0df032fb")
                    .frame(maxWidth: .infinity, minHeight: 200)
                HStack {
                    Spacer()
                    Text("Data: 21/11/2021")
                        .font(.caption)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.gray)
                }
            }
            .padding(16)
        }
        .frame(maxWidth: .infinity, minHeight: 300)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 5)
    }
}
