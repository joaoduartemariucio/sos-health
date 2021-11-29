//
//  StepPhoneNumberView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import iPhoneNumberField
import SwiftUI

struct StepPhoneNumberView: View {

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
                    Text("text_field_phone")
                        .foregroundColor(Color.primary)
                        .font(.title)
                        .bold()
                }
                VStack(spacing: 8) {
                    iPhoneNumberField(text: $viewModel.phone)
                        .flagHidden(false)
                        .flagSelectable(true)
                        .maximumDigits(11)
                        .underlineTextField()
                    if error {
                        Text("Telefone inválido")
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
                            if viewModel.validate() {
                                error = false
                                coordinator.route(to: \.birthDate, viewModel.user)
                            } else {
                                error = true
                            }
                        }
                    ).frame(width: 120, height: 50)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(28)
        }
    }
}

extension StepPhoneNumberView {

    class ViewModel: ObservableObject {

        // MARK: Proprieters

        var user: User

        @Published var phone: String = ""
        var cancellable: AnyCancellable?

        // MARK: Initializers

        init(user: User) {
            self.user = user

            cancellable = $phone.sink { [weak self] _ in
                _ = self?.validate()
            }
        }

        func validate() -> Bool {
            user.phoneNumber = phone.removeAllNonNumeric()
            return phone.isValidPhoneNumber
        }
    }
}
