//
//  HistoryView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 24/11/21.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.primary)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: reader.size.height * 0.14,
                            maxHeight: reader.size.height * 0.14,
                            alignment: .center
                        ).cornerRadius(0)
                    Text("Histórico")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: reader.size.height * 0.125 / 2, leading: 28, bottom: 0, trailing: 28))
                }
                List {
                    ForEach(1...5, id: \.self) { item in
                        HistoryCardView()
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }.edgesIgnoringSafeArea(.top)
    }
}
