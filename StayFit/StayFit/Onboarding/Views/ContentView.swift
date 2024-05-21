//
//  ContentView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(UserDefaultKeys.isLoggedIn) var status = false
    @StateObject var authVM = AuthenticationViewModel()
    var body: some View {
            if status{
                TabsView()
                    .environmentObject(authVM)
                    .onAppear() {
                        authVM.retrieveData()
                    }
            } else {
                SignUpView()
                    .environmentObject(authVM)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
