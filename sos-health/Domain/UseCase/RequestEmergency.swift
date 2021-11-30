//
//  RequestEmergency.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation

protocol RequestEmergency {
    func execute(event: EmergencyAction) async -> Bool
}

struct RequestEmergencyUseCase: RequestEmergency {

    var repo: RequestEmergencyRepository

    func execute(event: EmergencyAction) async -> Bool {
        return await repo.requestEvent(event: event)
    }
}
