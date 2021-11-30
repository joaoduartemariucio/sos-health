//
//  RequestEmergencyRepositoryImpl.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation

struct RequestEmergencyRepositoryImpl: RequestEmergencyRepository {

    var dataSource: RequestEmergencyDataSource

    func requestEvent(event: EmergencyAction) async -> Bool {
        return await dataSource.requestEvent(event: event)
    }
}
