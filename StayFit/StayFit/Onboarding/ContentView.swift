//
//  ContentView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToAddDetailsView = false
    
    var body: some View {
            SignUpView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
