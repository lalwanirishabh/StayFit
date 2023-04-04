//
//  StayFitApp.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI
import Firebase

@main

struct StayFitApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    let userData = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
    
    
}
