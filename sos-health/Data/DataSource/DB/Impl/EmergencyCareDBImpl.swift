//
//  EmergencyCareDBImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Combine
import FirebaseFirestore

struct EmergencyCareDBImpl: EmergencyCareDataSource {

    let db = Firestore.firestore()

    func getUnits(zipCode: String) async -> [CareUnits]? {
        let contactsRef = db.collection("emergency_care_units")

        do {
            let snapshots = try await contactsRef.whereField("zip_code", isEqualTo: zipCode).getDocuments()
            return nil
        } catch {
            return nil
        }
    }
}
