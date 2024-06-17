//
//  String+Extension.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 19/05/24.
//

import Foundation

extension String {
    var isNumber: Bool {
        get {
            return !self.isEmpty && self.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted) == nil
        }
    }
}
