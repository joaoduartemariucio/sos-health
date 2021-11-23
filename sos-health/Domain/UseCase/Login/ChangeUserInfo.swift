//
//  ChangeUserInfo.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 20/11/21.
//

import Firebase
import Foundation

protocol ChangeUserInfo {
    func execute(from user: User) async -> Result<Bool, UseCaseError>
}

struct ChangeUserInfoUseCase: ChangeUserInfo {

    var repo: LoginRepository

    func execute(from user: User) async -> Result<Bool, UseCaseError> {
        do {
            let result = try await repo.changeUserInfo(from: user)
            return .success(result)
        } catch {
            switch error {
            case DBServiceError.userNotFound:
                return .failure(.userNotFound)
            default:
                return .failure(.encodingError)
            }
        }
    }
}
