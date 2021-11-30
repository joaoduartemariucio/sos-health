//
//  EmergencyCareDataSource.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 28/11/21.
//

import Foundation

protocol EmergencyCareDataSource {
    func getUnits() async -> [CareUnits]?
}

