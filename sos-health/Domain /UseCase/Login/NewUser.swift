//
//  NewUser.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 18/11/21.
//

import Firebase
import Foundation
import GoogleSignIn

protocol NewUser {
    func execute(from uid: String) async -> Result<Bool, UseCaseError>
}

struct NewUserUseCase: NewUser {

    var repo: LoginRepository

    func execute(from uid: String) async -> Result<Bool, UseCaseError> {
        do {
            let result = try await repo.newUser(from: uid)
            return .success(result)
        } catch {
            switch error {
            default:
                return .failure(.encodingError)
            }
        }
    }
}
