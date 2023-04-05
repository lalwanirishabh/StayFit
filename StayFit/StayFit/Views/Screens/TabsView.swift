//
//  TabsView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

struct TabsView: View {
    
    @EnvironmentObject var userData : ViewModel
    
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Feed")
                }
                
            
            NavigationView {
                FeedView()
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
                
            
            NavigationView {
                BrowseView()
            }
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("Browse")
                }
                
            
            NavigationView {
                ProfileView2(name: userData.name, username: userData.username, email: userData.email, image: userData.image!)
            }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("profile")
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
