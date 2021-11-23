//
//  LoginView.ViewModel.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Foundation

extension LoginView {

    class ViewModel: ObservableObject {

        func login(email: String, password: String) {
            print("login", "email:", email, "password:", password)
        }
    }
}
