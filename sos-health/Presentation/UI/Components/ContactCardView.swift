//
//  ContactCardView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 23/11/21.
//

import SwiftUI

struct ContactCardView: View {

    @State var name: String
    @State var phoneNumber: String

    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer().frame(maxHeight: 4)
                Text(name)
                    .foregroundColor(.black)
                    .font(.callout)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(maxHeight: 8)
                Text(phoneNumber)
                    .foregroundColor(.black)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                HStack(spacing: 8) {
                    Button(action: {}) {
                        Image("avatar")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    }
                    Button(action: {}) {
                        Image("avatar")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }.padding()
        }
        .frame(minWidth: 180, maxHeight: 120, alignment: .leading)
        .background(Color.accentColor.opacity(0.05))
    }
}

struct ContactCardView_Previews: PreviewProvider {
    static var previews: some View {
        ContactCardView(name: "Carlos Manoel", phoneNumber: "(14) 99145-9179")
            .frame(width: 180)
    }
}
