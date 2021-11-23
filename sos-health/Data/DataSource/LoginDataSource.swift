//
//  LoginDataSource.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Combine
import Firebase
import GoogleSignIn
import SwiftUI

protocol LoginDataSource {

    func loginWithGoogle(completion: @escaping ((Result<Firebase.User, Error>) -> Void))

    func getUser(from uid: String) async throws -> User
    func newUser(from uid: String) async throws -> Bool

    func createLoginWithEmail(user: User) async throws -> Bool
    func checkCredentials(from credentials: Credentials) async throws -> Bool

    func changeUserInfo(from user: User) async throws -> Bool
}

extension LoginDataSource {

    func changeUserInfo(from user: User) async throws -> Bool {
        return false
    }

    func checkCredentials(from credentials: Credentials) async throws -> Bool {
        return false
    }

    func getUser(from uid: String) async throws -> User {
        throw DBServiceError.userNotFound
    }

    func newUser(from uid: String) async throws -> Bool {
        return false
    }

    func createLoginWithEmail(user: User) async throws -> Bool {
        return false
    }

    func loginWithGoogle(completion: @escaping ((Result<Firebase.User, Error>) -> Void)) {}
}
