//
//  SelectMeditationView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct SelectMeditationView: View {
    var body: some View {
        List {
            NavigationLink(destination: MeditationView(med: "med1")) {
                            Text("Meditation Sound 1")
                        }
            NavigationLink(destination: MeditationView(med: "med2")) {
                            Text("Meditation Sound 2")
                        }
            NavigationLink(destination: MeditationView(med: "med3")) {
                            Text("Meditation Sound 3")
                        }
                        
                    }
                    .navigationBarTitle("Musics")
                }
    }


struct SelectMeditationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectMeditationView()
            .preferredColorScheme(.dark)
    }
}
