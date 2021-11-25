//
//  Dictionary+Extensions.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 25/11/21.
//

import Foundation

extension Dictionary {

    func decode<T: Decodable>() throws -> T {
        let data = try JSONSerialization.data(withJSONObject: self)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
