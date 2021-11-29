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

    var isNeedFetchNewContact: Bool {
        get {
            UserDefaults.standard.bool(forKey: "user_created_new_contact")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "user_created_new_contact")
        }
    }

    var contacts: [Contact]? {
        get {
            if let decoded = UserDefaults.standard.data(forKey: "user_contacts"),
               let contactsSession = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [ContactSession] {
                return contactsSession.map { .init(name: $0.name, email: $0.email, phoneNumber: $0.phoneNumber, notify: $0.notify) }
            } else {
                return nil
            }
        }
        set {
            if let newContacts = newValue {
                let contactsSession: [ContactSession] = newContacts.map {
                    .init(name: $0.name, email: $0.email, phoneNumber: $0.phoneNumber, notify: $0.notify)
                }
                if let encoded = try? NSKeyedArchiver.archivedData(withRootObject: contactsSession, requiringSecureCoding: false) {
                    UserDefaults.standard.set(encoded, forKey: "user_contacts")
                }
            }
        }
    }

    var firebaseUser: Firebase.User? { FirebaseAuth.Auth.auth().currentUser }
}

class ContactSession: NSObject, NSCoding {

    var name: String
    var email: String
    var phoneNumber: String
    var notify: Bool

    init(name: String, email: String, phoneNumber: String, notify: Bool) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.notify = notify
    }

    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as! String
        let notify = aDecoder.decodeBool(forKey: "notify")
        self.init(name: name, email: email, phoneNumber: phoneNumber, notify: notify)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phoneNumber, forKey: "phoneNumber")
        aCoder.encode(notify, forKey: "notify")
    }
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
