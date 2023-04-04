//
//  BrowseView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct BrowseView: View {
    
    @EnvironmentObject var userData : ViewModel
    
    var body: some View {
        List {
                        NavigationLink(destination: SelectMeditationView()) {
                            Text("Meditation")
                        }
            NavigationLink(destination: BMIView(height: userData.height, weight: userData.weight)) {
                            Text("BMI")
                        }
                        NavigationLink(destination: ProfileView()) {
                            Text("Exercise Routine")
                        }
                        NavigationLink(destination: ProfileView()) {
                            Text("Recipes")
                        }
                        NavigationLink(destination: ProfileView()) {
                            Text("Book an Appointment")
                        }
                    }
                    .navigationBarTitle("Categories")
                }
    }


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
            .preferredColorScheme(.dark)
    }
}
