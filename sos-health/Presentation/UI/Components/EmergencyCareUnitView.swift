//
//  EmergencyCareUnitView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import SwiftUI

struct EmergencyCareUnitView: View {

    @State var image: UIImage
    @State var name: String
    @State var address: String
    @State var distance: String

    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 8) {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity, maxHeight: 142)
                VStack(spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "cross.fill")
                            .foregroundColor(.primary)
                            .frame(width: 12, height: 12)
                        Text(name)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 10) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.primary)
                            .frame(width: 12, height: 12)
                        Text(address)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack(spacing: 10) {
                        Image(systemName: "clock")
                            .foregroundColor(.primary)
                            .frame(width: 12, height: 12)
                        Text(distance)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }.padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 5)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 28, trailing: 5))
    }
}
