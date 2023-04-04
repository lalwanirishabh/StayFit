//
//  MainView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import HealthKit

struct MainView: View {
    
    private var healthStore : HealthStore?
    
    init(){
        healthStore = HealthStore()
    }
    
    var body: some View {
        ScrollView{
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
