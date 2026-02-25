//
//  User.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//

import FirebaseAuth
import Foundation

struct User {

    var uid: String?
    var fullName: String?
    var phoneNumber: String?
    var birthDate: String?
    var address: Address?
    var credentials: Credentials?
    var onboardCompleted: Bool?
    var firebaseUser: FirebaseAuth.User?
}

extension User {
    init(uid: String? = nil, onboardCompleted: Bool = false) {
        self.init(
            uid: uid,
            fullName: nil,
            phoneNumber: nil,
            birthDate: nil,
            address: .init(),
            credentials: .init(),
            onboardCompleted: onboardCompleted,
            firebaseUser: FirebaseAuth.Auth.auth().currentUser
        )
    }
}
