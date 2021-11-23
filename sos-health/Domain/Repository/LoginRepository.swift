//
//  LoginRepository.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Firebase
import GoogleSignIn

protocol LoginRepository {

    func checkCredentials(from credentials: Credentials) async throws -> Bool
    func getUser(from uid: String) async throws -> User
    func newUser(from uid: String) async throws -> Bool
    func loginWithGoogle(completion: @escaping ((Result<Firebase.User, Error>) -> Void))
    func changeUserInfo(from user: User) async throws -> Bool
    func createLoginWithEmail(user: User) async throws -> Bool
}
