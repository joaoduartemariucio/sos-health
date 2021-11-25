//
//  SampleItemView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 22/11/21.
//

import SwiftUI

struct SampleItemView: View {

    @State var title: String
    @Binding var subTitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(.black)
                .font(.callout)
                .bold()
                .opacity(0.5)
            Text(subTitle)
                .foregroundColor(.black)
                .font(.callout)
                .bold()
            Divider()
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
        }
        .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
    }
}
