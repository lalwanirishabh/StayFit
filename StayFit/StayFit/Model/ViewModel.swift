//
//  CurrentUser.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import Foundation
import UIKit

class ViewModel : ObservableObject {

    @Published var username: String = ""
    @Published var weight: Double = 0.0
    @Published var height: Double = 0.0
    @Published var name: String = "John"
    @Published var image: UIImage? = UIImage()
    @Published var dob: Date = Date()
    @Published var gender: String = ""
    @Published var email: String = ""
    @Published var Steps: Int = 0
    @Published var distance: Double = 0.0
    @Published var calories: Int = 0
    @Published var imageUrl : String = ""
    

    
}
