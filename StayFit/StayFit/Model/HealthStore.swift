//
//  HealthStore.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import Foundation
import HealthKit

class HealthStore{
    
    var HealthStore : HKHealthStore?
    
    init(){
        if HKHealthStore.isHealthDataAvailable(){
            HealthStore = HKHealthStore()
        }
    }
    
    
}
