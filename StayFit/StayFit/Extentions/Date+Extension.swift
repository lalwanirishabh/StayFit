//
//  Date+Extension.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 18/05/24.
//

import Foundation

extension Date {
    static func mondayAt12AM() -> Date {
        return Calendar(identifier: .iso8601).date(from: Calendar(identifier: .iso8601).dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

