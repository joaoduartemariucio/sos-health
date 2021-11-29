//
//  ContactDBImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Combine
import FirebaseFirestore

struct ContactDBImpl: ContactDataSource {

    let db = Firestore.firestore()

    func createContact(uid: String, contact: Contact) async -> Bool {
        do {
            let contact = try ContactDBEntity(
                uid: uid,
                name: contact.name,
                email: contact.email,
                phoneNumber: contact.phoneNumber,
                notify: contact.notify
            ).asDictionary()

            let newContactRef = db.collection("contacts").document()
            try await newContactRef.setData(contact)
            Preferences.shared.isNeedFetchNewContact = true
            return true
        } catch {
            return false
        }
    }

    func getContacts(uid: String) async -> [Contact]? {
        if !Preferences.shared.isNeedFetchNewContact, let contacts = Preferences.shared.contacts {
            return contacts
        } else {

            let contactsRef = db.collection("contacts")

            do {
                let snapshots = try await contactsRef.whereField("uid", isEqualTo: uid).getDocuments()

                let contactsDBEntity: [ContactDBEntity] = try snapshots.documents.compactMap {
                    let data = $0.data()
                    let contact: ContactDBEntity = try data.decode()
                    return contact
                }

                let contacts: [Contact] = contactsDBEntity.map {
                    .init(
                        name: $0.name,
                        email: $0.email,
                        phoneNumber: $0.phoneNumber,
                        notify: $0.notify
                    )
                }

                Preferences.shared.contacts = contacts

                return contacts
            } catch {
                return nil
            }
        }
    }
}
