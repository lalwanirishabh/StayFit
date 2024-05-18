//
//  GoogleSignInViewModel.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 07/05/24.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn

class GoogleSignInViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    
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
                UserDefaults.standard.set(uid, forKey: "uid")
                completion(true)
            }
        }
    }
}
