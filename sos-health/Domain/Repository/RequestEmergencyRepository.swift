//
//  RequestEmergencyRepository.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation

protocol RequestEmergencyRepository {
    func requestEvent(event: EmergencyAction) async -> Bool
}
