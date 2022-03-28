//
//  RequestEmergencyDBImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation


import Combine
import FirebaseFirestore

struct RequestEmergencyDBImpl: RequestEmergencyDataSource {

    let db = Firestore.firestore()

    func requestedEvents() async -> [RequestEmergencyDBEntity]? {
        do {
            let eventsRef = db.collection("requested_emergency")
            let uid = Preferences.shared.firebaseUser?.uid ?? ""
            let snapshots = try await eventsRef.whereField("uid", isEqualTo: uid).getDocuments()

            let eventsDBEntity: [RequestEmergencyDBEntity] = try snapshots.documents.compactMap {
                let data = $0.data()
                let event: RequestEmergencyDBEntity = try data.decode()
                return event
            }

            return eventsDBEntity
        } catch {
            return nil
        }
    }

    func requestEvent(event: EmergencyAction) async -> Bool {
        do {
            let event = try RequestEmergencyDBEntity(
                uid: Preferences.shared.firebaseUser?.uid ?? "",
                date: Date().eventDate,
                eventLat: Preferences.shared.location?.coordinate.latitude ?? 0,
                eventLong: Preferences.shared.location?.coordinate.longitude ?? 0,
                eventDesc: "Evento de \(event.title)",
                notified: false
            ).asDictionary()

            let newEventRef = db.collection("requested_emergency").document()
            try await newEventRef.setData(event)
            return true
        } catch {
            return false
        }
    }
}


extension Date {
    var eventDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
