//
//  StepEmailView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import SwiftUI

struct StepEmailView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var error = false

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("your_description")
                        .foregroundColor(Color.primary)
                        .font(.title)
                    Text("text_field_email")
                        .foregroundColor(Color.primary)
                        .font(.title)
                        .bold()
                }
                VStack(spacing: 8) {
                    TextField("text_field_email_place_holder", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .underlineTextField()
                    if error {
                        Text("O e-mail informado é inválido")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.clear)
                Group {
                    RoundedRectangleButton(
                        title: "Avançar",
                        backgroundColor: .primary,
                        action: {
                            if viewModel.validate() {
                                error = false
                                coordinator.route(to: \.name, viewModel.user)
                            } else {
                                error = true
                            }
                        }
                    ).frame(width: 120, height: 50)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
        }.padding(28)
    }
}

extension StepEmailView {

    class ViewModel: ObservableObject {

        // MARK: Proprieters

        var user: User

        @Published var email: String = ""
        var cancellable: AnyCancellable?

        // MARK: Initializers

        init(user: User) {
            self.user = user

            cancellable = $email.sink { [weak self] _ in
                _ = self?.validate()
            }
        }

        deinit {
            print("Deinit StepEmailView")
            cancellable?.cancel()
        }

        func validate() -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            user.credentials?.username = email
            return emailPred.evaluate(with: email)
        }
    }
}
