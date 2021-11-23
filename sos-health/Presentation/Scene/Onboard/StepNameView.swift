//
//  StepNameView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import SwiftUI

struct StepNameView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel
    @State var error = false

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("your_description")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                    Text("text_field_name")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .bold()
                }
                VStack(spacing: 8) {
                    TextField("text_field_name_place_holder", text: $viewModel.name).underlineTextField()
                    if error {
                        Text("O campo nome deve ser preenchido")
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
                            if viewModel.validate() {
                                error = false
                                coordinator.route(to: \.phoneNumber, viewModel.user)
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

extension StepNameView {

    class ViewModel: ObservableObject {

        // MARK: Proprieters

        var user: User

        @Published var name: String = ""
        var cancellable: AnyCancellable?

        // MARK: Initializers

        init(user: User) {
            self.user = user

            cancellable = $name.sink { [weak self] _ in
                _ = self?.validate()
            }
        }

        func validate() -> Bool {
            user.fullName = name
            return !name.isEmpty
        }
    }
}
