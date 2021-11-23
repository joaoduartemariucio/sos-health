//
//  LoginRepositoryImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Firebase
import Foundation

struct LoginRepositoryImpl: LoginRepository {

    var dataSource: LoginDataSource

    func checkCredentials(from credentials: Credentials) async throws -> Bool {
        return try await dataSource.checkCredentials(from: credentials)
    }

    func loginWithGoogle(completion: @escaping ((Result<Firebase.User, Error>) -> Void)) {
        dataSource.loginWithGoogle(completion: completion)
    }

    func getUser(from uid: String) async throws -> User {
        return try await dataSource.getUser(from: uid)
    }

    func newUser(from uid: String) async throws -> Bool {
        return try await dataSource.newUser(from: uid)
    }

    func createLoginWithEmail(user: User) async throws -> Bool {
        return try await dataSource.createLoginWithEmail(user: user)
    }

    func changeUserInfo(from user: User) async throws -> Bool {
        return try await dataSource.changeUserInfo(from: user)
    }
}
