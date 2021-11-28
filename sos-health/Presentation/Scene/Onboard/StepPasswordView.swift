//
//  StepPasswordView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import SwiftUI

struct StepPasswordView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var error = false
    @State var showError = false
    @State var errorMessage: String = ""
    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case .acceptablePassword:
            error = false
        case let .showError(showError):
            self.showError = showError
        case .passwordEmpty, .passwordShort:
            error = true
            errorMessage = state == .passwordEmpty ? "A senha deve ser preenchida" : "A senha é muito curta"
        default:
            break
        }
    }

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("set_a_description")
                        .foregroundColor(Color.primary)
                        .font(.title)
                    Text("text_field_password")
                        .foregroundColor(Color.primary)
                        .font(.title)
                        .bold()
                }
                VStack(spacing: 8) {
                    SecureInputView("text_field_password_place_holder".localized, text: $viewModel.password)
                        .underlineTextField()
                    if error && showError {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.clear)
                Group {
                    RoundedRectangleButton(
                        title: "button_next",
                        backgroundColor: .primary,
                        action: {
                            if viewModel.validate(showError: true) {
                                coordinator.route(to: \.confirmPassword, viewModel.user)
                            }
                        }
                    )
                    .frame(width: 120, height: 50)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }.onAppear {
                cancellable = viewModel.$state
                    .subscribe(on: sessionProcessingQueue)
                    .receive(on: DispatchQueue.main)
                    .sink { state in
                        self.handleViewModel(from: state)
                    }
            }.onDisappear {
                self.cancellable?.cancel()
            }
            .padding(28)
        }
    }
}

extension StepPasswordView {

    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State: Equatable {
            case acceptablePassword
            case passwordEmpty
            case passwordShort
            case showError(Bool)
            case `default`
        }

        // MARK: Proprieters

        var user: User

        @Published var password: String = ""
        @Published var state: State = .default
        var cancellable: AnyCancellable?

        // MARK: Life cycle

        init(user: User) {
            self.user = user

            cancellable = $password.sink { [weak self] _ in
                _ = self?.validate(showError: false)
            }
        }

        deinit {
            print("Deinit StepPasswordView")
            cancellable?.cancel()
        }

        // MARK: - Methods

        func validate(showError: Bool) -> Bool {
            state = .showError(showError)
            if !password.isEmpty {
                if password.count >= 8 {
                    user.credentials?.password = password
                    state = .acceptablePassword
                    return true
                } else {
                    state = .passwordShort
                }
            } else {
                state = .passwordEmpty
            }
            return false
        }
    }
}
