//
//  HomeView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import SwiftUI

struct HomeView: View {

    let rows = [
        GridItem(.flexible())
    ]

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        GeometryReader { _ in
            ScrollView {
                VStack(spacing: 24) {
                    Text("Contatos")
                        .foregroundColor(Color.accentColor)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, alignment: .center) {
                            ForEach(1 ... 50, id: \.self) { item in
                                Text("\(item)")
                                    .font(.largeTitle)
                                    .frame(minWidth: 180, maxHeight: .infinity)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(.orange)
                                    )
                            }
                        }
                        .frame(height: 110)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                    }
                    Text("Solicitações de emergência")
                        .foregroundColor(Color.accentColor)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(1 ... 6, id: \.self) { item in
                            Text("\(item)")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, minHeight: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.orange)
                                )
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 216)
                    .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    Text("Unidades de atendimento próximas")
                        .foregroundColor(Color.accentColor)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, alignment: .center) {
                            ForEach(1 ... 50, id: \.self) { item in
                                Text("\(item)")
                                    .font(.largeTitle)
                                    .frame(minWidth: 200, maxHeight: .infinity)
                                    .foregroundColor(.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(.orange)
                                    )
                            }
                        }
                        .frame(height: 272)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
