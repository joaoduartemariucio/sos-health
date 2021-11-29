//
//  ContactDataSource.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Foundation

protocol ContactDataSource {
    func createContact(uid: String, contact: Contact) async -> Bool
    func getContacts(uid: String) async -> [Contact]?
}
