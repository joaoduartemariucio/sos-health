//
//  AuthenticationService.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Firebase

class AuthenticationService: ObservableObject {
    enum Status: Equatable {
        case authenticated(Firebase.User)
        case unauthenticated
    }

    static var shared = AuthenticationService()

    @Published var status: Status?

    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                self?.status = .authenticated(user)
            } else {
                self?.status = .unauthenticated
            }
        }
    }
}
