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
    
    @State private var navigateToTabsView = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToAddDetailsView = false
    @State private var navigateToSignUpView = false
    @StateObject var googleSignInVM = GoogleSignInViewModel()
    
    //MARK: - BODY
    var body: some View {
        //MARK: -TEXTFIELDS
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
            GoogleSignInView()
                .padding(.horizontal)
                .onTapGesture {
                    print("Google Sign In clicked")
                }
            Spacer()
        }
        .fullScreenCover(isPresented: $navigateToTabsView, content: {
            TabsView()
        })
        .fullScreenCover(isPresented: $navigateToSignUpView, content: {
            SignUpView()
        })
    }
    
    
    //MARK: - FUNCTIONS
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
            UserDefaults.standard.set(uid, forKey: UserDefaultKeys.UserModel.uid)
            let ref = Database.database().reference()
            ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    UserModel.instance.username = value
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.username)
                    retrieveData2()
                }
            })
        }
    }
    
    func retrieveData2(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/name").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    UserModel.instance.name = value
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.name)
                }
            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/gender").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    UserModel.instance.gender = value
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.gender)
                }
            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/weight").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Double {
                    UserModel.instance.weight = value

                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/dailyStepsTarget").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Int {
                    UserModel.instance.dailyStepsTarget = value
                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/height").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Double {
                    UserModel.instance.height = value
                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            let ref = Database.database().reference()
            ref.child("users/\(UserModel.instance.username)/imageUrl").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String{
                    UserModel.instance.imageUrl = value
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.profileImageURL)
                    print(UserModel.instance.imageUrl)
                    guard let url = URL(string: "\(value)") else {
                        return
                    }
                    
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        if let error = error {
                            print("Error downloading image: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let data = data else {
                            print("Error: no data returned from server")
                            return
                        }
                        
                        DispatchQueue.main.async {
                            UserModel.instance.image = UIImage(data: data)
                            print("Hello")
                        }
                    }.resume()
                }
            })
        }
    }
    
    
}


//MARK: - PREVIEW
struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
