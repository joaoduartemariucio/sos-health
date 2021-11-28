//
//  MainView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 24/11/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var coordinator: AuthenticatedCoordinator.Router

    var body: some View {
        TabView {
            HomeView(viewModel: .init())
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            HistoryView()
                .tabItem {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Friends")
                }
            ProfileView(viewModel: .init())
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
        }
    }
}
