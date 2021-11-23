//
//  LoginAPIImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Firebase
import GoogleSignIn
import SwiftUI

struct LoginAPIImpl: LoginDataSource {

    let changeUserInfoUseCase = ChangeUserInfoUseCase(repo: LoginRepositoryImpl(dataSource: LoginDBImpl()))

    func loginWithGoogle(completion: @escaping ((Result<Firebase.User, Error>) -> Void)) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(APIServiceError.firebaseClient))
            return
        }

        let config = GIDConfiguration(clientID: clientID)

        guard let controller = UIApplication.shared.windows.first?.rootViewController else {
            completion(.failure(APIServiceError.firebaseClient))
            return
        }

        GIDSignIn.sharedInstance.signIn(with: config, presenting: controller) { user, error in
            if let error = error { completion(.failure(error)) }

            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                completion(.failure(APIServiceError.firebaseClient))
                return
            }

            let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credentials) { authData, error in
                if let error = error { completion(.failure(error)) }
                guard let authData = authData else {
                    completion(.failure(APIServiceError.firebaseClient))
                    return
                }

                completion(.success(authData.user))
            }
        }
    }

    func createLoginWithEmail(user: User) async throws -> Bool {
        var user = user
        guard let username = user.credentials?.username,
              let password = user.credentials?.password else {
            throw APIServiceError.requestError
        }

        if user.firebaseUser != nil {
            let credentials = EmailAuthProvider.credential(withEmail: username, password: password)
            try await user.firebaseUser?.link(with: credentials)
        } else {
            let result = try await Auth.auth().createUser(withEmail: username, password: password)
            user.uid = result.user.uid
        }

        let result = await changeUserInfoUseCase.execute(from: user)

        switch result {
        case let .success(isSuccess):
            return isSuccess
        case let .failure(error):
            throw error
        }
    }

    func checkCredentials(from credentials: Credentials) async throws -> Bool {

        return true
    }
}
