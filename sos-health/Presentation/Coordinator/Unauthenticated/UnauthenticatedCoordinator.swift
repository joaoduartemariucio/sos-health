//
//  UnauthenticatedCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//

import Foundation
import Stinsen
import SwiftUI

final class UnauthenticatedCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \UnauthenticatedCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var login = makeLogin
    @Route(.push) var onboarding = makeRegistration

    deinit {
        print("Deinit UnauthenticatedCoordinator")
    }
}

extension UnauthenticatedCoordinator {

    @ViewBuilder func makeLogin() -> some View {
        LoginView(viewModel: .init())
    }

    func makeRegistration(user: User) -> OnboardingCoordinator {
        return OnboardingCoordinator(user: user)
    }

    @ViewBuilder func makeStart() -> some View {
        WelcomeView(viewModel: .init())
    }
}
