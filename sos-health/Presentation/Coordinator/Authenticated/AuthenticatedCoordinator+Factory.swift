//
//  AuthenticatedCoordinator+Factory.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 27/11/21.
//

import Stinsen
import SwiftUI

extension AuthenticatedCoordinator {

    func makeHome() -> HomeCoordinator {
        return HomeCoordinator()
    }

    @ViewBuilder func makeHomeTab(isActive: Bool) -> some View {
        Image(systemName: "house" + (isActive ? ".fill" : ""))
        Text("Home")
    }

    func makeProfile() -> NavigationViewCoordinator<ProfileCoordinator> {
        return NavigationViewCoordinator(ProfileCoordinator())
    }

    @ViewBuilder func makeProfileTab(isActive: Bool) -> some View {
        Image(systemName: "person.fill")
        Text("Perfil")
    }
}
