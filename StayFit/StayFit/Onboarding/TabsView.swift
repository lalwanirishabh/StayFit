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
    

    //MARK: - BODY
    var body: some View {
        
        
        //MARK: - TABVIEW
        TabView {
            
            //MARK: - HOMEVIEW
            NavigationView {
                HomeView()
            }
                .tabItem {
                    Image(systemName: "house.circle")
                    Text("Feed")
                }
                
            //MARK: - FEEDVIEW
            NavigationView {
                FeedView()
            }
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
                
            //MARK: - BROWSEVIEW
            NavigationView {
                BrowseView()
            }
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("Browse")
                }
                
            //MARK: - PROFILEVIEW
            NavigationView {
                ProfileView2(name: UserModel.instance.name, username: UserModel.instance.username, email: UserModel.instance.email, image: UserModel.instance.image!)
            }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("profile")
                }
                
        }
        
    }

}

//MARK: - PREVIEW
struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        return TabsView()
            .preferredColorScheme(.dark)
        
    }
}
