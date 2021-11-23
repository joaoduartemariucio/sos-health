//
//  ProfileView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 20/11/21.
//

import Combine
import SwiftUI

struct ProfileView: View {

    @State var bounds = UIScreen.main.bounds
    @ObservedObject var viewModel: ViewModel
//    @EnvironmentObject private var coordinator: OnboardingCoordinator.Router
    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    @State var fullName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var birthDate: String = ""

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .updateUserProfile(user):
            fullName = user.fullName ?? ""
            email = user.credentials?.username ?? ""
            phone = user.phoneNumber ?? ""
            birthDate = user.birthDate ?? ""
        default:
            break
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.accentColor)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: bounds.size.height * 0.30,
                            maxHeight: bounds.size.height * 0.30,
                            alignment: .center
                        ).cornerRadius(0)
                    Image("avatar")
                        .resizable()
                        .frame(width: bounds.size.height * 0.15, height: bounds.size.height * 0.15)
                        .clipShape(Circle())
                }
                SampleItemView(title: "Nome completo", subTitle: fullName)
                SampleItemView(title: "E-Mail", subTitle: email)
                SampleItemView(title: "Telefone", subTitle: phone)
                SampleItemView(title: "Data de nascimento", subTitle: birthDate)
                RoundedRectangleButton(title: "Ver contatos de emergência", backgroundColor: .accentColor, action: {})
                    .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            viewModel.fetchUserInfos()
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

extension ProfileView {
    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case updateUserProfile(User)
            case `default`
        }

        @Published var state: State = .default

        func fetchUserInfos() {}
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: .init())
    }
}
