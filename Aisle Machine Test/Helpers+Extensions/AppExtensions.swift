//
//  AppExtensions.swift
//  Aisle Machine Test
//
//  Created by Iris Medical Solutions on 19/01/23.
//

import Foundation


extension String {
    public var isValidPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}
