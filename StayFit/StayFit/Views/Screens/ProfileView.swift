//
//  ProfileView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import HealthKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth
import URLImage
import FirebaseStorage

struct ProfileView: View {
    
    
    @EnvironmentObject var userData : ViewModel

    
    var body: some View {
        VStack {
            Image(uiImage : userData.image!)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
                    
            Text(userData.name)
                        .font(.title)
                        .padding()
                }
        .onAppear(perform: retrieveData)
    }
    
    func retrieveData(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(userData.username)/name").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    userData.name = value
                                    print(userData.name)
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(userData.username)/gender").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    userData.gender = value
                                    print(userData.gender)
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(userData.username)/weight").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? Double {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    userData.weight = value
                                    print(userData.weight)
                                }
                            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("users/\(userData.username)/height").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? Double {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    userData.height = value
                                    print(userData.height)
                                }
                            })
            
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            
            let ref = Database.database().reference()
            ref.child("users/\(userData.username)/image").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    guard let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/stayfit-64a79.appspot.com/o/images%2FUser56.jpg?alt=media&token=ad2e7e16-ae6e-4191-9e42-3528d97da981") else {
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
                                                    userData.image = UIImage(data: data)
                                                    print("Hello")
                                                }
                                            }.resume()
                                        }
                            })
            
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
