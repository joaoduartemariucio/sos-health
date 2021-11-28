//
//  WelcomeView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 10/11/21.
//

import AlertToast
import Combine
import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject private var coordinator: UnauthenticatedCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var cancellable: AnyCancellable?
    @State var loading = false
    @State var showError = false
    @State var error: UseCaseError?
    @State var sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .loading(isLoading):
            loading = isLoading
        case .success:
            Preferences.shared.userLoginComplete = true
            AuthenticationService.shared.status = .authenticated
        case let .error(error):
            showError = true
            self.error = error
        case .newUser(let user), .onboardNotCompleted(let user):
            coordinator.route(to: \.onboarding, user)
        default:
            break
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("welcome_title")
                .foregroundColor(Color.primary)
                .font(.body)
            Text("app_name")
                .foregroundColor(Color.primary)
                .font(.title)
                .bold()
            Text("welcome_description")
                .foregroundColor(.welcomeColor)
                .font(.subheadline)
            Spacer().frame(maxHeight: 46)
            HStack(spacing: 20) {
                RoundedRectangleButton(
                    title: "button_create_account",
                    backgroundColor: Color.primary.opacity(0.10),
                    foregroundColor: Color.primary,
                    action: {
                        let user = User(uid: nil, onboardCompleted: false)
                        coordinator.route(to: \.onboarding, user)
                    }
                )
                RoundedRectangleButton(
                    title: "button_login",
                    backgroundColor: Color.primary,
                    action: {
                        coordinator.route(to: \.login)
                    }
                )
            }
            Spacer().frame(maxHeight: 36)
            Text("welcome_option")
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color.primary)
                .font(.subheadline)
            Spacer().frame(maxHeight: 36)
            HStack(alignment: .center, spacing: 25) {
                Button(action: { print("button pressed") }) {
                    Image("facebook")
                        .resizable()
                        .renderingMode(.template)
                        .colorMultiply(.primary)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                Button(action: {
                    viewModel.loginWithGoogle()
                }) {
                    Image("google")
                        .resizable()
                        .renderingMode(.template)
                        .colorMultiply(.primary)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }.frame(minHeight: 0, maxHeight: 50)
        }
        .toast(
            isPresenting: $showError,
            duration: 5,
            tapToDismiss: false,
            alert: {
                AlertToast(
                    type: .error(Color.red),
                    title: error?.title,
                    subTitle: error?.description
                )
            }
        )
        .toast(
            isPresenting: $loading,
            tapToDismiss: false,
            alert: {
                AlertToast(type: .loading, title: "Loading...")
            }
        ).onAppear {
            cancellable = viewModel.$state
                .subscribe(on: sessionProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { state in
                    self.handleViewModel(from: state)
                }
        }.onDisappear {
            self.cancellable?.cancel()
        }
        .disabled(loading)
        .padding(28)
    }
}
