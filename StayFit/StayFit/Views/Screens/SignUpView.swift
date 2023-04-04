//
//  SignUpView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift




struct SignUpView: View {
    
    @EnvironmentObject var userData : ViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var username: String = ""
    @State private var navigateToAddDetailsView = false
    @State private var navigateToLogInView = false
    
    var body: some View {
        
        
        
        VStack {
            
            TextField("Username", text: $username)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
            
            
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
                           registerUser()
                       }) {
            Text("Sign Up")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                       }
                
            
            Button(action: {
                navigateToLogInView.toggle()
                       }) {
            Text("Already have an account. Click here")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
                       }
        }
        .fullScreenCover(isPresented: $navigateToAddDetailsView, content: {
            AddDetailsView()
        })
        .fullScreenCover(isPresented: $navigateToLogInView, content: {
            LogInView()
        })
        
        
        
        
    }
    
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!)
            }
            else{
                userData.username = username
                
                
                guard let uid = result?.user.uid else { return }
                let ref = Database.database().reference()
                let userRef = ref.child("users").child(uid)
                let userData = ["username": username]
                userRef.setValue(userData)
                navigateToAddDetailsView.toggle()
                 }
            }
        }
    
    
}

    


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.dark)
    }
}
