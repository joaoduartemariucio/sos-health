//
//  EmergencyActions.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 24/11/21.
//

import Foundation
import SwiftUI

enum EmergencyAction: String, CaseIterable {

    case help
    case fire
    case doctor
    case police
    case asthma
    case fall

    var title: String {
        switch self {
        case .help: return "Socorro"
        case .fire: return "Fogo"
        case .doctor: return "Médico"
        case .police: return "Polícia"
        case .asthma: return "Asma"
        case .fall: return "Queda"
        }
    }

    var color: Color {
        switch self {
        case .help:
            return .red
        case .fire:
            return .orange
        case .doctor:
            return .green
        case .police:
            return .init(.sRGB, red: 22 / 255, green: 80 / 255, blue: 148 / 255, opacity: 0.8)
        case .asthma:
            return .init(.sRGB, red: 56 / 255, green: 64 / 255, blue: 69 / 255, opacity: 0.8)
        case .fall:
            return .yellow
        }
    }

    var icon: String {
        switch self {
        case .help:
            return rawValue
        case .fire:
            return rawValue
        case .doctor:
            return rawValue
        case .police:
            return rawValue
        case .asthma:
            return rawValue
        case .fall:
            return rawValue
        }
    }
}
