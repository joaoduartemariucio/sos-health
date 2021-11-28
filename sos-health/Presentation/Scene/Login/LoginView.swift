//
//  LoginView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import SwiftUI

struct LoginView: View {

    @State var email = ""
    @State var password = ""

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 24) {
                Text("app_name")
                    .foregroundColor(Color.accentColor)
                    .font(.title)
                    .bold()
                Text("login_description")
                    .foregroundColor(Color("WelcomeDescription"))
                    .font(.subheadline)
                TextField("text_field_email_place_holder", text: $email).underlineTextField()
                TextField("text_field_password_place_holder", text: $password).underlineTextField()
                Button(action: { print("login") }) {
                    Text("button_forgot_password")
                        .font(.caption)
                        .bold()
                        .underline()
                }.frame(maxWidth: .infinity, alignment: .trailing)
                Spacer().frame(maxHeight: 26)
                Group {
                    RoundedRectangleButton(
                        title: "button_login",
                        backgroundColor: .accentColor,
                        action: { viewModel.login(email: email, password: password) }
                    ).frame(maxWidth: 226)
                }.frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(28)
        }
    }
}
