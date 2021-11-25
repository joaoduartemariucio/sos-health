//
//  AuthenticatedCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 20/11/21.
//

import Stinsen
import SwiftUI

final class AuthenticatedCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \AuthenticatedCoordinator.start)

    @Root var start = makeStart

    deinit {
        print("Deinit UnauthenticatedCoordinator")
    }
}

extension AuthenticatedCoordinator {

    @ViewBuilder func makeStart() -> some View {
        MainView()
    }
}
