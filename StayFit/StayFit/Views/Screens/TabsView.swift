//
//  TabsView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            NavigationView {
                // main screen
            }
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Feed")
                }
            
            NavigationView {
                // main screen
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                // main screen
            }
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("Feed")
                }
            
            NavigationView {
                    
                    SignUpView()
            }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
            .preferredColorScheme(.dark)
    }
}
