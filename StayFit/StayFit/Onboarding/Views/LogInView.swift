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
    //MARK: - VARIABLES
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAddDetailsView = false
    @EnvironmentObject var authVM : AuthenticationViewModel
    @Environment (\.presentationMode) var presentationMode
    
    //MARK: - BODY
    var body: some View {
        //MARK: - TEXTFIELDS
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 200)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
            //MARK: - BUTTONS
            Button(action: {
                UserDefaults.standard.set(email, forKey: UserDefaultKeys.UserModel.email)
                UserModel.instance.email = email
                authVM.loginUserUsingEmailPassword(email: email, password: password)
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
                self.presentationMode.wrappedValue.dismiss()
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
            GoogleSignInView()
                .padding(.horizontal)
                .onTapGesture {
                    print("Google Sign In clicked")
                }
            Spacer()
        }
    }
}


//MARK: - PREVIEW
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
