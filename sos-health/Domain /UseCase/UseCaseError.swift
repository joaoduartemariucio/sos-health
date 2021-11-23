//
//  UseCaseError.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 18/11/21.
//

import Foundation

enum UseCaseError: Error {
    case networkError, decodingError, encodingError, loginError, userNotFound, onboardNotCompleted

    var title: String {
        switch self {
        default:
            return "System unavailable"
        }
    }

    var description: String {
        switch self {
        default:
            return "Sorry but our services are currently unavailable"
        }
    }
}
