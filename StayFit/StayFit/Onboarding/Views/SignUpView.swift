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
    @AppStorage(UserDefaultKeys.UserModel.email) var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAddDetailsView = false
    @State var navigateToHomeView = false
    @State private var navigateToLogInView = false
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State var navigateToSignUpWithNumberView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        // MARK: - TEXTFIELDS
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
            // MARK: - BUTTONS
            Button(action: {
                UserDefaults.standard.set(email, forKey: UserDefaultKeys.UserModel.email)
                UserModel.instance.email = email
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
            .fullScreenCover(isPresented: $navigateToLogInView, content: {
                LogInView()
                    .environmentObject(authVM)
            })
            Button(action: {
                navigateToSignUpWithNumberView.toggle()
            }) {
                Text("Sign Up with Mobile Number")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .fullScreenCover(isPresented: $navigateToSignUpWithNumberView, content: {
                SignUpWithMobileNumberView()
            })
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
    }
    
    //MARK: - FUNCTIONS
    func registerUser(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!)
            }
            else{
                guard let uid = result?.user.uid else { return }
                UserModel.instance.uid = uid
                UserDefaults.standard.set(uid, forKey: UserDefaultKeys.UserModel.uid)
                navigateToAddDetailsView.toggle()
            }
        }
    }
}

//MARK: - PREVIEW
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}
