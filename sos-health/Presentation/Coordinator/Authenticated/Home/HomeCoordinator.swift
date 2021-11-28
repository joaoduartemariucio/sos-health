//
//  HomeCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 25/11/21.
//

import Stinsen
import SwiftUI

final class HomeCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \HomeCoordinator.start)

    @Root var start = makeStart

    deinit {
        print("Deinit HomeCoordinator")
    }
}

extension HomeCoordinator {

    @ViewBuilder func makeStart() -> some View {
        HomeView(viewModel: .init())
    }
}
