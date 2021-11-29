//
//  LoginDBImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//

import Combine
import FirebaseFirestore

struct LoginDBImpl: LoginDataSource {

    let db = Firestore.firestore()

    func getUser(from uid: String) async throws -> User {
        let document = try await db.collection("users").document(uid).getDocument()

        guard let documentData = document.data() else {
            throw DBServiceError.userNotFound
        }

        let user: UserDBEntity = try documentData.decode()
        return .init(
            uid: uid,
            fullName: user.fullName,
            phoneNumber: user.phoneNumber,
            address: .init(
                city: user.address?.city,
                completation: user.address?.completation,
                number: user.address?.number,
                state: user.address?.state,
                streat: user.address?.streat,
                zipCode: user.address?.zipCode
            ),
            credentials: nil,
            onboardCompleted: user.onboardCompleted
        )
    }

    func newUser(from uid: String) async throws -> Bool {
        let user = UserDBEntity()
        let dictionary = try user.asDictionary()
        try await db.collection("users").document(uid).setData(dictionary)
        return true
    }

    func changeUserInfo(from user: User) async throws -> Bool {
        guard let uid = user.uid else {
            throw DBServiceError.userNotFound
        }

        let dictionary = try UserDBEntity(
            fullName: user.fullName,
            phoneNumber: user.phoneNumber,
            address: .init(
                city: user.address?.city,
                completation: user.address?.completation,
                number: user.address?.number,
                state: user.address?.state,
                streat: user.address?.streat,
                zipCode: user.address?.zipCode
            ),
            onboardCompleted: user.onboardCompleted
        ).asDictionary()

        try await db.collection("users").document(uid).setData(dictionary)
        return true
    }
}
