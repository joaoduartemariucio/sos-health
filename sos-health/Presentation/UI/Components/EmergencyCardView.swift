//
//  EmergencyCardView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 23/11/21.
//

import SwiftUI

struct EmergencyCardView: View {

    @State var name: String
    @State var image: String
    @State var color: Color

    var body: some View {
        VStack {
            Text(name)
                .foregroundColor(.white)
                .font(.callout)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            Button(action: {}) {
                Image(image)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
        .frame(maxWidth: 100, maxHeight: 100, alignment: .leading)
        .background(color)
        .cornerRadius(16)
    }
}

struct EmergencyCardView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyCardView(name: "Socorro", image: "help", color: .red)
    }
}
