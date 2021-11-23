//
//  MainCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//
import Foundation
import Stinsen
import SwiftUI

final class MainCoordinator: NavigationCoordinatable {
    var stack: NavigationStack<MainCoordinator>

    @Root var unauthenticated = makeUnauthenticated
    @Root var authenticated = makeAuthenticated

    @ViewBuilder func sharedView(_ view: AnyView) -> some View {
        view
            .onReceive(AuthenticationService.shared.$status, perform: { status in
                switch status {
                case let .authenticated(user):
                    self.root(\.authenticated)
                case .none, .unauthenticated:
                    self.root(\.unauthenticated)
                }
            })
    }

    deinit {
        print("Deinit MainCoordinator")
    }

    init() {
        switch AuthenticationService.shared.status {
        case let .authenticated(user):
            stack = NavigationStack(initial: \MainCoordinator.authenticated)
        case .none, .unauthenticated:
            stack = NavigationStack(initial: \MainCoordinator.unauthenticated)
        }
    }
}

extension MainCoordinator {
    func makeUnauthenticated() -> NavigationViewCoordinator<UnauthenticatedCoordinator> {
        return NavigationViewCoordinator(UnauthenticatedCoordinator())
    }

    func makeAuthenticated(user: User) -> AuthenticatedCoordinator {
        return AuthenticatedCoordinator()
    }
}
