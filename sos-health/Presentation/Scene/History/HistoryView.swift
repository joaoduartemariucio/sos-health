//
//  HistoryView.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 24/11/21.
//

import SwiftUI

struct HistoryView: View {

    @State var events = [ModelRequestEmergency]()
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        GeometryReader { reader in
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.primary)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: reader.size.height * 0.14,
                            maxHeight: reader.size.height * 0.14,
                            alignment: .center
                        ).cornerRadius(0)
                    Text("Histórico")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: reader.size.height * 0.125 / 2, leading: 28, bottom: 0, trailing: 28))
                }
                List {
                    ForEach(events, id: \.self) { item in
                        HistoryCardView(event: item)
                            .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            Task {
                events = await viewModel.fetchValues().map {
                    .init(uid: $0.uid, date: $0.date, eventLat: $0.eventLat, eventLong: $0.eventLong, eventDesc: $0.eventDesc, notified: $0.notified)
                }
            }
        }
    }
}

extension HistoryView {

    class ViewModel: ObservableObject {

        let repo = RequestEmergencyDBImpl()

        func fetchValues() async -> [RequestEmergencyDBEntity] {
            return await repo.requestedEvents() ?? [RequestEmergencyDBEntity]()
        }
    }
}
