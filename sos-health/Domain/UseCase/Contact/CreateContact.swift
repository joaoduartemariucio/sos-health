//
//  CreateContact.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Foundation

protocol CreateContact {
    func execute(uid: String, contact: Contact) async -> Bool
}

struct CreateContactUseCase: CreateContact {

    var repo: ContactRepository

    func execute(uid: String, contact: Contact) async -> Bool {
        return await repo.createContact(uid: uid, contact: contact)
    }
}
