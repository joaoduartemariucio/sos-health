//
//  WelcomeView.ViewModel.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 10/11/21.
//

import FirebaseFirestore
import Foundation
import SwiftUI

extension WelcomeView {

    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case error(UseCaseError)
            case loading(Bool)
            case newUser(User)
            case onboardNotCompleted(User)
            case success
            case `default`
        }

        var loginWithGoogleUseCase = LoginWithGoogleUseCase(repo: LoginRepositoryImpl(dataSource: LoginAPIImpl()))
        var getUserUseCase = GetUserUseCase(repo: LoginRepositoryImpl(dataSource: LoginDBImpl()))
        var newUserUseCase = NewUserUseCase(repo: LoginRepositoryImpl(dataSource: LoginDBImpl()))

        @Published var state: State = .default
        func createAccount() {}

        func login() {}

        func loginWithGoogle() {
            loginWithGoogleUseCase.execute { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(user):
                    self.state = .loading(true)
                    Task {
                        let result = try await self.checkIfUserCompletedOnboard(uid: user.uid)

                        var newUser = User(uid: user.uid, onboardCompleted: false)
                        newUser.fullName = user.displayName
                        newUser.phoneNumber = user.phoneNumber
                        newUser.credentials?.username = user.email
                        newUser.firebaseUser = user

                        switch result {
                        case let .success(value):
                            self.state = .loading(false)
                            self.state = value ? .success : .onboardNotCompleted(newUser)
                        case let .failure(error):
                            if error == .userNotFound {
                                await self.newUser(uid: user.uid, user: newUser)
                            } else {
                                self.state = .error(error)
                            }
                        }
                    }
                case let .failure(error):
                    self.state = .error(error)
                }
            }
        }

        func checkIfUserCompletedOnboard(uid: String) async throws -> Result<Bool, UseCaseError> {
            let result = await getUserUseCase.execute(from: uid)
            switch result {
            case let .success(user):
                if !(user.onboardCompleted ?? false) {
                    return .success(false)
                } else {
                    return .success(true)
                }
            case let .failure(error):
                state = .loading(false)
                return .failure(error)
            }
        }

        func newUser(uid: String, user: User) async {
            let result = await newUserUseCase.execute(from: uid)

            state = .loading(false)
            switch result {
            case let .success(isSuccess):
                state = isSuccess ? .newUser(user) : .error(.networkError)
            case let .failure(error):
                state = .error(error)
            }
        }
    }
}
