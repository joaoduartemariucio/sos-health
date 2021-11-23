//
//  GetUser.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 17/11/21.
//

import Firebase
import GoogleSignIn

protocol GetUser {
    func execute(from uid: String) async -> Result<User, UseCaseError>
}

struct GetUserUseCase: GetUser {

    var repo: LoginRepository

    func execute(from uid: String) async -> Result<User, UseCaseError> {
        do {
            let user = try await repo.getUser(from: uid)
            return .success(user)
        } catch {
            switch error {
            case DBServiceError.userNotFound:
                return .failure(.userNotFound)
            default:
                return .failure(.decodingError)
            }
        }
    }
}
