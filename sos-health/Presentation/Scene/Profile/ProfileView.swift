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
    @EnvironmentObject private var coordinator: ProfileCoordinator.Router
    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "ProfileViewQueue")
    @State var fullName: String = ""
    @State var email: String = ""
    @State var phone: String = ""
    @State var birthDate: String = ""
    @State var isProfileImage: Bool = false
    @State var profileImage = UIImage()

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        UIScrollView.appearance().bounces = false
        UINavigationBar.appearance().isHidden = true
    }

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .updateUserProfile(user):
            fullName = user.fullName ?? ""
            phone = user.phoneNumber ?? ""
            birthDate = user.birthDate ?? ""
        case let .updateUserEmail(email):
            self.email = email
        case let .updateUserPhoto(image):
            isProfileImage = true
            profileImage = image
        default:
            break
        }
    }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.primary)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: bounds.size.height * 0.30,
                            maxHeight: bounds.size.height * 0.30,
                            alignment: .center
                        ).cornerRadius(0)
                    if !isProfileImage {
                        Image("avatar")
                            .resizable()
                            .frame(width: bounds.size.height * 0.15, height: bounds.size.height * 0.15)
                            .clipShape(Circle())
                    } else {
                        Image(uiImage: profileImage)
                            .resizable()
                            .frame(width: bounds.size.height * 0.15, height: bounds.size.height * 0.15)
                            .clipShape(Circle())
                    }
                }
                SampleItemView(title: "Nome completo", subTitle: $fullName)
                SampleItemView(title: "E-Mail", subTitle: $email)
                SampleItemView(title: "Telefone", subTitle: $phone)
                SampleItemView(title: "Data de nascimento", subTitle: $birthDate)
                RoundedRectangleButton(
                    title: "Ver contatos de emergência",
                    backgroundColor: .primary,
                    action: {
                        coordinator.route(to: \.contacts)
                    }
                )
                .padding(EdgeInsets(top: 0, leading: 28, bottom: 0, trailing: 28))
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            cancellable = viewModel.$state
                .subscribe(on: sessionProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { state in
                    self.handleViewModel(from: state)
                }
            viewModel.loadView()
        }.onDisappear {
            self.cancellable?.cancel()
        }
    }
}

extension ProfileView {
    class ViewModel: ObservableObject {

        // MARK: - Additional states

        enum State {
            case updateUserProfile(UserSession)
            case updateUserEmail(String)
            case updateUserPhoto(UIImage)
            case `default`
        }

        @Published var state: State = .default

        func loadView() {
            fetchUserInfos()
            fetchProfileEmail()
            fetchProfileImage()
        }

        func fetchUserInfos() {
            guard let user = Preferences.shared.user else { return }
            state = .updateUserProfile(user)
        }

        func fetchProfileEmail() {
            guard let firebaseUser = Preferences.shared.firebaseUser else { return }
            state = .updateUserEmail(firebaseUser.email ?? "")
        }

        func fetchProfileImage() {
            guard let firebaseUser = Preferences.shared.firebaseUser,
                  let photoURL = firebaseUser.photoURL else { return }
            let task = URLSession.shared.dataTask(with: photoURL) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.state = .updateUserPhoto(image)
                }
            }
            task.resume()
        }
    }
}
