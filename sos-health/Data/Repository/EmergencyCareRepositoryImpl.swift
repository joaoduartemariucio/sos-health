//
//  EmergencyCareRepositoryImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Foundation

struct EmergencyCareRepositoryImpl: EmergencyCareRepository {

    var dataSource: EmergencyCareDataSource

    func getUnits() async -> [CareUnits]? {
        return await dataSource.getUnits()
    }
}
