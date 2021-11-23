//
//  VerifyLoginCredentials.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Foundation

protocol VerifyLoginCredentials {
    func execute() async -> Result<Bool, UseCaseError>
}

struct VerifyLoginCredentialsUseCase: VerifyLoginCredentials {

    var repo: LoginRepository
    var credentials: Credentials

    func execute() async -> Result<Bool, UseCaseError> {
        do {
            let result = try await repo.checkCredentials(from: credentials)
            return .success(result)
        } catch {
            switch error {
            case APIServiceError.decodingError:
                return .failure(.decodingError)
            default:
                return .failure(.networkError)
            }
        }
    }
}
