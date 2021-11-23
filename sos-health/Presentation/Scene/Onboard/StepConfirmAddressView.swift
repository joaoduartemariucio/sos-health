//
//  StepConfirmAddressView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 14/11/21.
//

import Combine
import SwiftUI

struct StepConfirmAddressView: View {

    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading, spacing: 36) {
                HStack {
                    Text("confirm_description")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                    Text("address_description")
                        .foregroundColor(Color.accentColor)
                        .font(.title)
                        .bold()
                }
                TextField("text_field_streat_place_holder", text: $viewModel.streat).underlineTextField()
                HStack {
                    TextField("text_field_complement_place_holder", text: $viewModel.completation).underlineTextField()
                    TextField("text_field_number_place_holder", text: $viewModel.number)
                        .underlineTextField()
                        .frame(maxWidth: 120)
                }
                HStack {
                    TextField("text_field_city_place_holder", text: $viewModel.city).underlineTextField()
                    TextField("text_field_state_place_holder", text: $viewModel.state)
                        .underlineTextField()
                        .frame(maxWidth: 120)
                }
                RoundedRectangle(cornerRadius: 6)
                    .foregroundColor(.clear)
                Group {
                    RoundedRectangleButton(
                        title: "button_next",
                        backgroundColor: .accentColor,
                        action: {
                            coordinator.route(to: \.password, viewModel.user)
                        }
                    ).frame(width: 120, height: 50)
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(28)
        }
    }
}

extension StepConfirmAddressView {

    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case loading(Bool)
            case invalidEmail
            case `default`
        }

        // MARK: Proprieters

        var user: User

        @Published var city: String = ""
        @Published var completation: String = ""
        @Published var number: String = ""
        @Published var state: String = ""
        @Published var streat: String = ""

        var subscriptions = Set<AnyCancellable>()

        // MARK: Initializers

        init(user: User) {
            self.user = user
            configureDataPipeline()
        }

        deinit {
            subscriptions.forEach { $0.cancel() }
            print("Deinit StepConfirmAddressView")
        }

        func configureDataPipeline() {
            $streat
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.user.address?.streat = $0
                }
                .store(in: &subscriptions)

            $completation
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.user.address?.completation = $0
                }
                .store(in: &subscriptions)

            $number
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.user.address?.number = $0
                }
                .store(in: &subscriptions)

            $city
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.user.address?.city = $0
                }
                .store(in: &subscriptions)

            $state
                .sink { [weak self] in
                    guard let self = self else { return }
                    self.user.address?.state = $0
                }
                .store(in: &subscriptions)
        }
    }
}
