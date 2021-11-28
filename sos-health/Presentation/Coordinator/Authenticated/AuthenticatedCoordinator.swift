//
//  AuthenticatedCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 20/11/21.
//

import Stinsen
import SwiftUI

final class AuthenticatedCoordinator: TabCoordinatable {

    var child = TabChild(
        startingItems: [
            \AuthenticatedCoordinator.home,
            \AuthenticatedCoordinator.profile
        ]
    )

    @Route(tabItem: makeHomeTab) var home = makeHome
    @Route(tabItem: makeProfileTab) var profile = makeProfile

    deinit {
        print("Deinit UnauthenticatedCoordinator")
    }
}

extension AuthenticatedCoordinator {

    func makeHome() -> HomeCoordinator {
        return HomeCoordinator()
    }

    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        Image(systemName: "house" + (isActive ? ".fill" : ""))
        Text("Home")
    }

    func makeProfile() -> ProfileCoordinator {
        return ProfileCoordinator()
    }

    @ViewBuilder func makeProfileTab(isActive: Bool) -> some View {
        Image(systemName: "person.fill")
        Text("Perfil")
    }
}
