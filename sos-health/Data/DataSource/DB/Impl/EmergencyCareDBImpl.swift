//
//  EmergencyCareDBImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Combine
import FirebaseFirestore
import CoreLocation

struct EmergencyCareDBImpl: EmergencyCareDataSource {

    let db = Firestore.firestore()

    func getUnits() async -> [CareUnits]? {
        do {
            let snapshots = try await db.collection("emergency_care_units").getDocuments()

            let careUnits: [CareUnits] = snapshots.documents.compactMap {
                return CareUnits(
                    name: $0.get("locale_name") as? String ?? "",
                    address: $0.get("address") as? String ?? "",
                    city: $0.get("city") as? String ?? "",
                    uf: $0.get("uf") as? String ?? "",
                    urlImage: $0.get("url_image") as? String ?? "",
                    zipCode: $0.get("zip_code") as? String ?? "",
                    coords: .init(latitude: 0, longitude: 0)
                )
            }

            return careUnits
        } catch {
            return nil
        }
    }
}
