//
//  HeaderView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 27/11/21.
//

import SwiftUI

struct HeaderView: View {

    var reader: GeometryProxy
    @Binding var title: String
    var dimensions: Double

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.primary)
                .frame(
                    maxWidth: .infinity,
                    minHeight: reader.size.height * dimensions,
                    maxHeight: reader.size.height * dimensions,
                    alignment: .center
                ).cornerRadius(0)
            Text("Contatos")
                .foregroundColor(Color.white)
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: reader.size.height * (dimensions / 2), leading: 28, bottom: 0, trailing: 28))
        }
    }
}
