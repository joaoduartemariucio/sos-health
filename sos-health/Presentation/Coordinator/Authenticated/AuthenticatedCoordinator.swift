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
