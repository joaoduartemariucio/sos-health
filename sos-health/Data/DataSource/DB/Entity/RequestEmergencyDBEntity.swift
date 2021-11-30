//
//  RequestEmergencyDBEntity.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation

struct RequestEmergencyDBEntity: Codable {

    var uid: String
    var date: String
    var eventLat: Double
    var eventLong: Double
    var eventDesc: String
    var notified: Bool
}
