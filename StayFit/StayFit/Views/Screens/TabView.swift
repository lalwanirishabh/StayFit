//
//  TabView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        ScrollView{
            NavigationView {
                // main screen
            }
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Feed")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}
