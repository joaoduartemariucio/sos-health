//
//  StepDateBirthView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import SwiftUI

struct StepDateBirthView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("your_description")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                    Text("text_field_date_birth")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .bold()
                }
                DatePicker(selection: $viewModel.birthDate, in: ...Date(), displayedComponents: .date) {
                    Text("Selecione uma data:")
                }
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.clear)
                Group {
                    RoundedRectangleButton(
                        title: "button_next",
                        backgroundColor: .accentColor,
                        action: {
                            coordinator.route(to: \.zipCode, viewModel.user)
                        }
                    ).frame(width: 120, height: 50)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(28)
        }
    }
}

extension StepDateBirthView {

    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case loading(Bool)
            case invalidEmail
            case `default`
        }

        // MARK: Proprieters

        var user: User

        @Published var birthDate = Date()
        var cancellable: AnyCancellable?

        // MARK: Initializers

        init(user: User) {
            self.user = user

            cancellable = $birthDate.sink { [weak self] _ in
                self?.validate()
            }
        }

        func validate() {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            user.birthDate = formatter.string(from: birthDate)
        }
    }
}
