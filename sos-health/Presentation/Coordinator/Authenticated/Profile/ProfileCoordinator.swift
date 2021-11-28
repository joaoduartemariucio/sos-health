//
//  ProfileCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 25/11/21.
//

import Stinsen
import SwiftUI

final class ProfileCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \ProfileCoordinator.start)

    @Root var start = makeStart
    @Route(.push) var contacts = makeContacts

    deinit {
        print("Deinit ProfileCoordinator")
    }
}

extension ProfileCoordinator {

    @ViewBuilder func makeStart() -> some View {
        ProfileView(viewModel: .init())
    }

    @ViewBuilder func makeContacts() -> some View {
        ContactsView()
    }
}
