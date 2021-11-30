//
//  HistoryCoordinator.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 29/11/21.
//

import Stinsen
import SwiftUI

final class HistoryCoordinator: NavigationCoordinatable {

    let stack = NavigationStack(initial: \HistoryCoordinator.start)

    @Root var start = makeStart

    deinit {
        print("Deinit HomeCoordinator")
    }
}

extension HistoryCoordinator {

    @ViewBuilder func makeStart() -> some View {
        HistoryView()
    }
}
