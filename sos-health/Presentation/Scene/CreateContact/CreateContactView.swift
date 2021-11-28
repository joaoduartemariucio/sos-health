//
//  CreateContactView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 22/11/21.
//

import Combine
import iPhoneNumberField
import SwiftUI

struct CreateContactView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel

    @State var errorName = false
    @State var errorEmail = false
    @State var errorPhoneNumber = false
    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "CreateContactViewQueue")

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .loading(isLoading): break
        default:
            break
        }
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
                    action: {}
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
            case `default`
        }

        // MARK: Proprieters

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
    }
}
