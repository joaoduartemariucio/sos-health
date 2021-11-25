//
//  MainCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 15/11/21.
//
import Combine
import Foundation
import Stinsen
import SwiftUI

final class MainCoordinator: NavigationCoordinatable {
    var stack: NavigationStack<MainCoordinator>

    @Root var unauthenticated = makeUnauthenticated
    @Root var authenticated = makeAuthenticated

    @State var cancellable: AnyCancellable?
    @State var quee = DispatchQueue(label: "MainCoordinatorQueue")

    init() {
        switch AuthenticationService.shared.status {
        case .authenticated:
            stack = NavigationStack(initial: \MainCoordinator.authenticated)
        case .unauthenticated:
            stack = NavigationStack(initial: \MainCoordinator.unauthenticated)
        }

        cancellable = AuthenticationService.shared.$status
            .subscribe(on: quee)
            .receive(on: DispatchQueue.main)
            .sink { state in
                switch state {
                case .authenticated:
                    self.root(\.authenticated)
                case .unauthenticated:
                    self.root(\.unauthenticated)
                }
            }
    }

    deinit {
        cancellable?.cancel()
        print("Deinit MainCoordinator")
    }
}

extension MainCoordinator {
    func makeUnauthenticated() -> NavigationViewCoordinator<UnauthenticatedCoordinator> {
        return NavigationViewCoordinator(UnauthenticatedCoordinator())
    }

    func makeAuthenticated() -> AuthenticatedCoordinator {
        return AuthenticatedCoordinator()
    }
}
