//
//  CreateUser.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 20/11/21.
//

import Foundation

protocol CreateUser {
    func execute(from user: User) async -> Result<Bool, UseCaseError>
}

struct CreateUserUseCase: CreateUser {

    var repo: LoginRepository

    func execute(from user: User) async -> Result<Bool, UseCaseError> {
        do {
            let result = try await repo.createLoginWithEmail(user: user)
            return .success(result)
        } catch {
            switch error {
            default:
                return .failure(.encodingError)
            }
        }
    }
}
