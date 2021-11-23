//
//  StepConfirmPasswordView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import AlertToast
import Combine
import SwiftUI

struct StepConfirmPasswordView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var error = false
    @State var showError = false
    @State var cancellable: AnyCancellable?
    @State var loading = false
    @State var toastError = false
    @State var sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .loading(isLoading):
            loading = isLoading
        case .passwordEquals:
            error = false
        case .passwordNotEquals:
            error = true
        case .showError(let show):
            showError = show
        case .error:
            toastError = true
        case .success:
            // TODO: Manda o fdp para a tela home
            break
        default:
            break
        }
    }

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("repeat_your_description")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                    Text("text_field_password")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .bold()
                }
                VStack(spacing: 8) {
                    SecureInputView("text_field_password_place_holder".localized, text: $viewModel.password)
                        .underlineTextField()
                    if error && showError {
                        Text("As senhas não se coincidem")
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
                        backgroundColor: .accentColor,
                        action: {
                            if viewModel.validate(showError: true) {
                                viewModel.confirmOnboardInfos()
                            }
                        }
                    )
                    .disabled(toastError)
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
            .toast(isPresenting: $loading, tapToDismiss: false) {
                AlertToast(type: .loading, title: "Loading...")
            }
            .toast(
                isPresenting: $toastError,
                duration: 5,
                tapToDismiss: false,
                alert: {
                    AlertToast(
                        type: .error(Color.red),
                        title: "Falha ao criar a conta",
                        subTitle: "Tente novamente"
                    )
                }, completion: {
                    coordinator.dismissCoordinator()
                }
            )
            .disabled(loading)
            .padding(28)
        }
    }
}

extension StepConfirmPasswordView {

    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case loading(Bool)
            case passwordEquals
            case passwordNotEquals
            case success
            case error(String)
            case showError(Bool)
            case `default`
        }

        // MARK: Proprieters

        var user: User

        var createUserUseCase = CreateUserUseCase(repo: LoginRepositoryImpl(dataSource: LoginAPIImpl()))

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
            print("Deinit StepConfirmPasswordView")
            cancellable?.cancel()
        }

        // MARK: - Methods

        func validate(showError: Bool) -> Bool {
            if password == user.credentials?.password {
                state = .passwordEquals
                user.onboardCompleted = true
                return true
            } else {
                state = .passwordNotEquals
                return false
            }
        }

        func confirmOnboardInfos() {
            state = .loading(true)
            Task {
                let result = await createUserUseCase.execute(from: user)
                state = .loading(false)
                switch result {
                case let .success(isSuccess):
                    state = isSuccess ? .success : .error(UseCaseError.networkError.description)
                case let .failure(error):
                    state = .error(error.description)
                }
            }
        }
    }
}
