//
//  ContentView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var userData : ViewModel
    @State private var navigateToAddDetailsView = false
    
    var body: some View {
        if userData.isUserLoggedIn == false
        {
            SignUpView()
        }else{
            ProfileView2(name: userData.name, username: userData.username, email: userData.email, image: userData.image!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
