//
//  OnboardingCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//

import Foundation
import Stinsen
import SwiftUI

final class OnboardingCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \OnboardingCoordinator.start)

    @Route(.push) var start = makeStart
    @Route(.push) var name = makeName
    @Route(.push) var phoneNumber = makePhoneNumber
    @Route(.push) var birthDate = makeBirthDate
    @Route(.push) var zipCode = makeZipCode
    @Route(.push) var confirmAddress = makeConfirmAddress
    @Route(.push) var password = makePassword
    @Route(.push) var confirmPassword = makeConfirmPassword

    let user: User

    init(user: User) {
        self.user = user
    }

    deinit {
        print("Deinit OnboardingCoordinator")
    }
}

extension OnboardingCoordinator {

    @ViewBuilder func makeStart() -> some View {
        if user.credentials?.username != nil {
            if user.fullName != nil {
                if user.phoneNumber != nil {
                    StepDateBirthView(viewModel: .init(user: user))
                } else {
                    StepPhoneNumberView(viewModel: .init(user: user))
                }
            } else {
                StepNameView(viewModel: .init(user: user))
            }
        } else {
            StepEmailView(viewModel: .init(user: user))
        }
    }

    @ViewBuilder func makeName(user: User) -> some View {
        StepNameView(viewModel: .init(user: user))
    }

    @ViewBuilder func makePhoneNumber(user: User) -> some View {
        StepPhoneNumberView(viewModel: .init(user: user))
    }

    @ViewBuilder func makeBirthDate(user: User) -> some View {
        StepDateBirthView(viewModel: .init(user: user))
    }

    @ViewBuilder func makeZipCode(user: User) -> some View {
        StepZipCodeView(viewModel: .init(user: user))
    }

    @ViewBuilder func makeConfirmAddress(user: User) -> some View {
        StepConfirmAddressView(viewModel: .init(user: user))
    }

    @ViewBuilder func makePassword(user: User) -> some View {
        StepPasswordView(viewModel: .init(user: user))
    }

    @ViewBuilder func makeConfirmPassword(user: User) -> some View {
        StepConfirmPasswordView(viewModel: .init(user: user))
    }
}
