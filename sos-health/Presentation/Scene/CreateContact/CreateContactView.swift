//
//  CreateContactView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 22/11/21.
//

import AlertToast
import Combine
import iPhoneNumberField
import SwiftUI

struct CreateContactView: View {

    @EnvironmentObject private var coordinator: ProfileCoordinator.Router
    @ObservedObject var viewModel: ViewModel

    @State var isLoading = false
    @State var errorName = false
    @State var errorEmail = false
    @State var errorPhoneNumber = false
    @State var errorSave = false
    @State var successSave = false

    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "CreateContactViewQueue")

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .loading(isLoading):
            self.isLoading = isLoading
        case .invalidName:
            errorName = true
        case .invalidEmail:
            errorEmail = true
        case .invalidPhoneNumber:
            errorPhoneNumber = true
        case .saveError:
            errorSave = true
        case .saveSuccess:
            successSave = true
        default:
            break
        }
    }

    func resetErrors() {
        errorName = false
        errorEmail = false
        errorPhoneNumber = false
    }

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                VStack(spacing: 8) {
                    TextField("text_field_name_place_holder", text: $viewModel.name)
                        .underlineTextField()
                    if errorName {
                        Text("O campo nome deve ser preenchido")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: 8)
                    TextField("text_field_email_place_holder", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .underlineTextField()
                    if errorEmail {
                        Text("O e-mail informado é inválido")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity, maxHeight: 8)
                    iPhoneNumberField(text: $viewModel.phoneNumber)
                        .flagHidden(false)
                        .flagSelectable(true)
                        .maximumDigits(11)
                        .underlineTextField()
                    if errorPhoneNumber {
                        Text("Telefone inválido")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                Toggle("Notificar contato em emergências", isOn: $viewModel.notify)
                RoundedRectangleButton(
                    title: "Salvar",
                    backgroundColor: .primary,
                    action: {
                        resetErrors()
                        viewModel.createContact()
                    }
                ).frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .navigationBarTitle("Novo Contato")
        .navigationBarTitleDisplayMode(.large)
        .padding(28)
        .onAppear {
            cancellable = viewModel.$state
                .subscribe(on: sessionProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { state in
                    self.handleViewModel(from: state)
                }
        }.onDisappear {
            self.cancellable?.cancel()
        }
        .toast(
            isPresenting: $isLoading,
            tapToDismiss: false,
            alert: {
                AlertToast(type: .loading, title: "Loading...")
            }
        )
        .toast(
            isPresenting: $errorSave,
            duration: 5,
            tapToDismiss: false,
            alert: {
                AlertToast(
                    type: .error(Color.red),
                    title: "Falha",
                    subTitle: "Algo deu errado, mas você pode tentar novamente assim que quiser"
                )
            }, completion: {
                coordinator.pop()
            }
        )
        .toast(
            isPresenting: $successSave,
            duration: 5,
            tapToDismiss: false,
            alert: {
                AlertToast(
                    type: .complete(.green),
                    title: "Sucesso",
                    subTitle: "Você verá esse contato na primeira tela do app"
                )
            }, completion: {
                coordinator.pop()
            }
        )
    }
}

extension CreateContactView {

    class ViewModel: ObservableObject {

        // MARK: Additional states

        enum State {
            case loading(Bool)
            case invalidName
            case invalidEmail
            case invalidPhoneNumber
            case saveError
            case saveSuccess
            case `default`
        }

        // MARK: Proprieters
        var createContactUseCase = CreateContactUseCase(repo: ContactRepositoryImpl(dataSource: ContactDBImpl()))
        var subscriptions = Set<AnyCancellable>()
        var contact: Contact

        @Published var state: State = .default
        @Published var name: String = ""
        @Published var email: String = ""
        @Published var phoneNumber: String = ""
        @Published var notify: Bool = false

        // MARK: Initializers

        init(contact: Contact) {
            self.contact = contact
            configureDataPipeline()
        }

        deinit {
            subscriptions.forEach { $0.cancel() }
            print("Deinit CreateContactView")
        }

        func configureDataPipeline() {
            $name
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.contact.name = $0
                }
                .store(in: &subscriptions)

            $email
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.contact.email = $0
                }
                .store(in: &subscriptions)

            $phoneNumber
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.contact.phoneNumber = $0
                }
                .store(in: &subscriptions)

            $notify
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.contact.notify = $0
                }
                .store(in: &subscriptions)
        }

        func createContact() {
            state = .loading(true)
            if name.isEmpty {
                state = .loading(false)
                state = .invalidName
                return
            }

            if email.isEmpty, !email.isValidEmail {
                state = .loading(false)
                state = .invalidEmail
                return
            }

            if phoneNumber.isEmpty, !phoneNumber.isValidPhoneNumber {
                state = .loading(false)
                state = .invalidPhoneNumber
                return
            } else {
                contact.phoneNumber = phoneNumber.removeAllNonNumeric()
            }

            guard let uid = Preferences.shared.firebaseUser?.uid else {
                state = .saveError
                state = .loading(false)
                return
            }

            Task {
                let result = await createContactUseCase.execute(uid: uid, contact: contact)
                state = result ? .saveSuccess : .saveError
                state = .loading(false)
            }
        }
    }
}
