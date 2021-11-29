//
//  ContactRepositoryImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Foundation

struct ContactRepositoryImpl: ContactRepository {

    var dataSource: ContactDataSource

    func createContact(uid: String, contact: Contact) async -> Bool {
        return await dataSource.createContact(uid: uid, contact: contact)
    }

    func getContacts(uid: String) async -> [Contact]? {
        return await dataSource.getContacts(uid: uid)
    }
}
