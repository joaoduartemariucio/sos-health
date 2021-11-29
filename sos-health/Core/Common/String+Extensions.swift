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

    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }

    var isValidPhoneNumber: Bool {
        let phoneNumber = self.removeAllNonNumeric()
        return phoneNumber.count == 11
    }

    func removeAllNonNumeric() -> String {
        return self.filter("0123456789".contains)
    }

    // mask example: `+X (XXX) XXX-XXXX`
    func format(with mask: String) -> String {
        let numbers = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
}
