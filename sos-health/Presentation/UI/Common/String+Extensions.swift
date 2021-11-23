//
//  String+Extensions.swift
//  sos-health
//
//  Created by João Vitor Duarte Mariucio on 19/11/21.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }

    func localized(_ args: CVarArg...) -> String {
        return String(format: localized, args)
    }
}
