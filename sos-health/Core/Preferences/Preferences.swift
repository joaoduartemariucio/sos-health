//
//  Preferences.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 25/11/21.
//

import Firebase
import Foundation

class Preferences {

    static var shared = Preferences()

    var userLoginComplete: Bool {
        get { UserDefaults.standard.bool(forKey: "user_login_complete") }
        set { UserDefaults.standard.set(newValue, forKey: "user_login_complete") }
    }

    var user: UserSession? {
        get {
            let dict = UserDefaults.standard.object(forKey: "user_session") as? [String: Any]
            do {
                return try dict?.decode()
            } catch {
                return nil
            }
        }
        set {
            let dict = newValue?.dictionary
            UserDefaults.standard.set(dict, forKey: "user_session")
        }
    }

    var firebaseUser: Firebase.User? { FirebaseAuth.Auth.auth().currentUser }
}

struct UserSession: Codable {

    var uid: String?
    var fullName: String?
    var phoneNumber: String?
    var birthDate: String?
    var onboardCompleted: Bool?
}

extension UserSession {
    init(user: User) {
        self.init(
            uid: user.uid,
            fullName: user.fullName,
            phoneNumber: user.phoneNumber,
            birthDate: user.birthDate,
            onboardCompleted: user.onboardCompleted
        )
    }
}
