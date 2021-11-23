//
//  APIServiceError.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 13/11/21.
//

import Foundation

enum APIServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK, firebaseClient

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
