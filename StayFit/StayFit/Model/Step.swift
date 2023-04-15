//
//  Step.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import Foundation

// MARK: - USERDAILYSTEPDATA

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    let date: Date
}
