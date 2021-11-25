//
//  AuthenticationService.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Firebase

class AuthenticationService: ObservableObject {
    enum Status: Equatable {
        case authenticated
        case unauthenticated
    }

    static var shared = AuthenticationService()

    @Published var status: Status

    init() {
        status = Preferences.shared.userLoginComplete ? .authenticated : .unauthenticated
    }
}
