//
//  ContactsView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 22/11/21.
//

import Combine
import SwiftUI

struct ContactsView: View {

    // MARK: Environments

    @EnvironmentObject private var coordinator: ProfileCoordinator.Router
    @ObservedObject var viewModel: ViewModel

    // MARK: States

    @State var cancellable: AnyCancellable?
    @State var sessionProcessingQueue = DispatchQueue(label: "ContactsViewQueue")
    @State var contacts = [Contact]()
    @State var isEmptyContacts: Bool = false

    // MARK: Initializers

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    // MARK: Methods

    func handleViewModel(from state: ViewModel.State) {
        switch state {
        case let .loading(isLoading): break
        case let .updateContacts(contacts):
            self.contacts = contacts
        default:
            break
        }
    }

    // MARK: Body

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                HStack {
                    Text("Contatos")
                        .foregroundColor(Color.primary)
                        .font(.title)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(28)
                if !isEmptyContacts {
                    List {
                        ForEach(contacts, id: \.self) { item in
                            SampleItemStaticView(
                                title: item.name,
                                subTitle: item.phoneNumber
                            ).padding()
                        }
                    }
                    .listStyle(.plain)
                } else {
                    VStack {
                        Spacer()
                        Text("Você não possui contatos cadastrados")
                            .foregroundColor(Color.primary)
                            .font(.footnote)
                        Spacer()
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { coordinator.route(to: \.createContact) }) {
                        Image(systemName: "plus")
                            .font(.custom("", size: 24))
                            .frame(width: 56, height: 56)
                            .background(Color.primary)
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .padding()
                    .shadow(radius: 2)
                }
            }
        }
        .navigationBarTitle("Contatos")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            cancellable = viewModel.$state
                .subscribe(on: sessionProcessingQueue)
                .receive(on: DispatchQueue.main)
                .sink { state in
                    self.handleViewModel(from: state)
                }
            viewModel.fetchContacts()
        }.onDisappear {
            self.cancellable?.cancel()
        }
    }
}

extension ContactsView {

    class ViewModel: ObservableObject {

        // MARK: Additional states

        enum State {
            case loading(Bool)
            case updateContacts([Contact])
            case emptyContacts(Bool)
            case `default`
        }

        // MARK: Properties

        @Published var state: State = .default

        // MARK: Methods

        func fetchContacts() {}
    }
}
