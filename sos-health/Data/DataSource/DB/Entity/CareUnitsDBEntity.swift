//
//  CareUnitsDBEntity.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 30/11/21.
//

import Foundation
import Firebase

struct CareUnitsDBEntity: Codable {

    var name: String?
    var address: String?
    var city: String?
    var uf: String?
    var urlImage: String?
    var zipCode: String?

    enum CodingKeys: String, CodingKey {
        case name = "locale_name"
        case address
        case city
        case uf
        case urlImage =  "url_image"
        case zipCode = "zip_code"
    }
}
