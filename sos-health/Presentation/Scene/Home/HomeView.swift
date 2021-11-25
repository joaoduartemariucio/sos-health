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

    init() {
//        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
    }

    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.accentColor)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: reader.size.height * 0.125,
                            maxHeight: reader.size.height * 0.125,
                            alignment: .center
                        ).cornerRadius(0)
                }
                VStack(spacing: 24) {
                    Text("Contatos")
                        .foregroundColor(Color.accentColor)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows, alignment: .center) {
                            ForEach(1 ... 10, id: \.self) { item in
                                ContactCardView(name: "name \(item)", phoneNumber: "phone \(item)")
                            }
                        }
                        .frame(height: 120)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 0))
                    }
                    Text("Solicitações de emergência")
                        .foregroundColor(Color.accentColor)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(EmergencyAction.allCases, id: \.self) { item in
                            EmergencyCardView(name: item.title, image: item.icon, color: item.color)
                                .frame(minWidth: reader.size.width / 3 - (28 * 2), minHeight: reader.size.height * 0.125)
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
                }.padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

extension HomeView {

    class ViewModel: ObservableObject {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
