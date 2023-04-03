//
//  SignUpView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 03/04/23.
//

import SwiftUI
import Firebase



struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    @State private var navigateToAddDetailsView = false
    
    var body: some View {
        
        
        
        VStack {
            
//            TextField("Username", text: $username)
//                            .padding()
//                            .background(Color(.secondarySystemBackground))
//                            .cornerRadius(10)
//                            .padding(.horizontal)
            
            
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
                
            
            NavigationLink(destination: LogInView()) {
                                Text("Already have an account. Click Here")
                            }
            .padding()
        }
        .fullScreenCover(isPresented: $navigateToAddDetailsView, content: {
            AddDetailsView()
        })
        
        
        
        
    }
    
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!)
            }
            else{
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
