//
//  LogInView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth

struct LogInView: View {
    
    @EnvironmentObject var userData : ViewModel
    
    @State private var navigateToTabsView = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAddDetailsView = false
    @State private var navigateToSignUpView = false

    
    var body: some View {
        
        
        VStack {
            
            TextField("Email", text: $email)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button(action: {
                           loginUser()
                       }) {
            Text("Log In")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                       }
            
            Button(action: {
                navigateToSignUpView.toggle()
                       }) {
            Text("Dont have an account. Click here")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                       }
            
            
        }
        .fullScreenCover(isPresented: $navigateToTabsView, content: {
            TabsView()
        })
        .fullScreenCover(isPresented: $navigateToSignUpView, content: {
            SignUpView()
        })
    }
    
    func loginUser(){
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            }else{
                retrieveData()
                navigateToTabsView.toggle()
            }
        }
    }
    
    func retrieveData(){
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    userData.username = value
                                }
                            })
        }
    
        
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .preferredColorScheme(.dark)
    }
}
