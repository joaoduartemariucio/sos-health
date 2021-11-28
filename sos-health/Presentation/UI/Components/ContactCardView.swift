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
                        Image(systemName: "message.fill")
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.accentColor)
                            .clipShape(Circle())
                    }
                    Button(action: {}) {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.accentColor)
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
