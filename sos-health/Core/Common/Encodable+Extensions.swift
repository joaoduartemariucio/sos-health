//
//  Encodable+Extensions.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 25/11/21.
//

import Foundation

extension Encodable {

    var dictionary: [String: Any]? {
        do {
            return try asDictionary()
        } catch {
            return nil
        }
    }

    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
