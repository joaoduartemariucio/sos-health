//
//  GetEmergencyCareUnits.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation

protocol GetEmergencyCareUnits {
    func execute() async -> [CareUnits]?
}

struct GetEmergencyCareUnitsUseCase: GetEmergencyCareUnits {

    var repo: EmergencyCareRepository

    func execute() async -> [CareUnits]? {
        return await repo.getUnits()
    }
}
