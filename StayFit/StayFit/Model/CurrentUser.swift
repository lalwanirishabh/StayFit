//
//  CurrentUser.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var weight: Double = 0.0
    @Published var height: Double = 0.0
    @Published var name: String = ""
    @Published var image: UIImage? = UIImage()
    @Published var dob: Date = Date()
    
    
}
