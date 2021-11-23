//
//  CreateContactView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 22/11/21.
//

import Combine
import iPhoneNumberField
import SwiftUI

struct CreateContactView_Previews: PreviewProvider {
    static var previews: some View {
        CreateContactView(viewModel: .init())
    }
}

struct CreateContactView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var errorName = false
    @State var errorEmail = false
    @State var errorPhoneNumber = false

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("Novo")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                    Text("contato")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .bold()
                }
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
                    backgroundColor: .accentColor,
                    action: {}
                ).frame(maxWidth: .infinity, alignment: .trailing)
            }
        }.padding(28)
    }
}

extension CreateContactView {

    class ViewModel: ObservableObject {

        // MARK: Proprieters

        var cancellable: AnyCancellable?

        @Published var name: String = ""
        @Published var email: String = ""
        @Published var phoneNumber: String = ""
        @Published var notify: Bool = false

        // MARK: Initializers

        init() {
//
//            cancellable = $email.sink { [weak self] _ in
//                _ = self?.validate()
//            }
        }

        deinit {
            print("Deinit CreateContactView")
            cancellable?.cancel()
        }

//        func validate() -> Bool {
//
//        }
    }
}
