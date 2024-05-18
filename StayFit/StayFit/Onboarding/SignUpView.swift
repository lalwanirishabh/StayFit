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
    
    // MARK: - VARIABLES
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State var username: String = ""
    @State private var navigateToAddDetailsView = false
    @State var navigateToHomeView = false
    @State private var navigateToLogInView = false
    @StateObject var googleSignInVM = GoogleSignInViewModel()
    
    // MARK: - BODY
    var body: some View {
        // MARK: - TEXTFIELDS
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 150)
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
            // MARK: - BUTTONS
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
            GoogleSignInView()
                .padding(.horizontal)
                .onTapGesture {
                    print("Google Sign In clicked")
                }
            Spacer()
        }
        .fullScreenCover(isPresented: $navigateToAddDetailsView, content: {
            AddDetailsView()
        })
        .fullScreenCover(isPresented: $navigateToLogInView, content: {
            LogInView()
        })
    }
    
    //MARK: - FUNCTIONS
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!)
            }
            else{
                UserModel.instance.username = username
                UserModel.instance.email = email
                UserModel.instance.isUserLoggedIn = true
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

//MARK: - PREVIEW
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
