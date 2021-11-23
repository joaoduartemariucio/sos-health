//
//  LoginWithGoogle.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//

import Firebase
import Foundation
import GoogleSignIn

protocol LoginWithGoogle {
    func execute(completion: @escaping ((Result<Firebase.User, UseCaseError>) -> Void))
}

struct LoginWithGoogleUseCase: LoginWithGoogle {

    var repo: LoginRepository

    func execute(completion: @escaping ((Result<Firebase.User, UseCaseError>) -> Void)) {
        repo.loginWithGoogle { result in
            switch result {
            case let .success(user):
                completion(.success(user))
            case .failure:
                completion(.failure(.loginError))
            }
        }
    }
}
