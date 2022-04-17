//
//  StringExtension.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import Foundation

extension String {
    var isValidNIC: Bool {
        let nicRegEx = "^(?:19|20)?\\d{2}[0-9]{10}|[0-9]{9}[x|X|v|V]$"
        let nicPred = NSPredicate(format:"SELF MATCHES %@", nicRegEx)
        return nicPred.evaluate(with: self)
    }
    var isValidName: Bool {
        return self.count > 1
    }
    var isValidMail: Bool {
        let mailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let mailPred = NSPredicate(format:"SELF MATCHES %@", mailRegEx)
        return mailPred.evaluate(with: self)
    }
    var isValidMobile: Bool {
        let mobileRegEx = "^\\d{3}\\d{3}\\d{4}$"
        let mobilePred = NSPredicate(format:"SELF MATCHES %@", mobileRegEx)
        return mobilePred.evaluate(with: self)
    }
    var isNumber: Bool {
        return Int(self) != nil
    }
}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
