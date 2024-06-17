//
//  AuthenticationViewModel.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 19/05/24.
//

import Foundation
import Firebase
import SwiftUI
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    @AppStorage(UserDefaultKeys.isLoggedIn) var status = false
    @AppStorage(UserDefaultKeys.UserModel.uid) var uid: String = ""
    @Published var selectedCountryCode: String = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var error = false
    @Published var codeFromFirebase: String = ""
    @Published var codeFromUser: String = ""
    @Published var goToVerify = false
    @Published var showAuthenticationPage: Bool = true
    @Published var goToHome: Bool = false
    
    func loginUserUsingEmailPassword(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e)
            }else{
                self.retrieveData()
            }
        }
    }
    
    func sendCode() {
        Auth.auth().settings?.isAppVerificationDisabledForTesting = false
        let phoneNumber = UserModel.instance.phoneNumber
        isLoading = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            guard let strongSelf = self else { return }
            strongSelf.isLoading = false
            if let error {
                print("Error occurred sending verification code: \(error)")
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.error.toggle()
                return
            }
            strongSelf.codeFromFirebase = verificationID ?? ""
            strongSelf.goToVerify = true
        }
    }
    
    func verifyCode(completion: @escaping (Bool) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: codeFromFirebase,
            verificationCode: codeFromUser
        )
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if let error {
               print("Error occurred verifying code: \(error)")
                strongSelf.errorMessage = error.localizedDescription
                strongSelf.error.toggle()
                return
            }
            print("Logged In")
            strongSelf.showAuthenticationPage = false
            strongSelf.uid = authResult?.user.uid ?? ""
            UserModel.instance.uid = authResult?.user.uid ?? ""
            strongSelf.goToHome = true
            self?.doesUserAlreadyExist(uid: self?.uid ?? "", completion: { exists, userData in
                if exists {
                    completion(true)
                } else {
                    completion(false)
                }
                
            })
        }
        
    }
    
    func performInitialSetupOnSignUp() {
        
    }
    
    func performInitialSetupOnLogIn() {
        
    }
    
    func retrieveData(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            UserDefaults.standard.set(uid, forKey: UserDefaultKeys.UserModel.uid)
            UserModel.instance.uid = uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/username").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    UserModel.instance.username = value
                    print("username is \(value)")
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.username)
                    self.retrieveData2()
                }
            })
        }
    }
    
    func retrieveData2(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/name").observeSingleEvent(of: .value, with: { snapshot in
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
            ref.child("users/\(uid)/weight").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Double {
                    UserModel.instance.weight = value

                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/dailyStepsTarget").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Int {
                    UserModel.instance.dailyStepsTarget = value
                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/height").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Double {
                    UserModel.instance.height = value
                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(uid)/dob").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Int {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "ddmmyy"
                    UserModel.instance.dob = dateFormatter.date(from: String(value)) ?? .now
                }
            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            let ref = Database.database().reference()
            ref.child("users/\(uid)/imageUrl").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String{
                    UserModel.instance.imageUrl = value
                    UserDefaults.standard.set(value, forKey: UserDefaultKeys.UserModel.profileImageURL)
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
    
    func doesUserAlreadyExist(uid: String, completion: @escaping (Bool, [String: Any]?) -> Void) {
        let ref = Database.database().reference()
        ref.child("users/\(uid)").getData { error, snapshot in
            if let error = error {
                print("Error getting data \(error)")
                completion(false, nil)
            } else if snapshot != nil && snapshot!.exists() {
                if let userData = snapshot!.value as? [String: Any] {
                    completion(true, userData)
                } else {
                    completion(true, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }
    
    func signInWithGoogle(completion: @escaping (Bool) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
                completion(false)
                return
            }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: Application_utility.rootViewController) { user, error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            guard let user = user?.user, let idToken = user.idToken else {
                completion(false)
                return
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)
            let email = Auth.auth().currentUser?.email
            UserModel.instance.email = email ?? ""
            UserDefaults.standard.set(email, forKey: UserDefaultKeys.UserModel.email)
            Auth.auth().signIn (with: credential) { res, error in
                if let error = error {
                    print (error.localizedDescription)
                    completion(false)
                    return
                }
                guard let user = res?.user else {
                    completion(false)
                    return
                }
                let uid = res?.user.uid
                UserDefaults.standard.set(uid, forKey: UserDefaultKeys.UserModel.uid)
                UserModel.instance.uid = uid ?? ""
                self.doesUserAlreadyExist(uid: self.uid, completion: { exists, userData in
                    if exists {
                        completion(true)
                    } else {
                        completion(false)
                    }
                })
            }
        }
    }
}
