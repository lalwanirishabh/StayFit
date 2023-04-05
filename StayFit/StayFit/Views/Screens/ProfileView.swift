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
    @State private var navigateToSignUpView = false
    let today = Date()
    
    func datetoString(date : Date) -> String{
        let dateFormatter = DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        let dateString = formatter.string(from: today)
        return dateString
    }

    
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
                        .padding(.top)
            
            Text("@\(userData.username)")
                        .font(.title3)
            
            Text(userData.email)
                        .font(.title3)
            
            Button(action: {
                let ref = Database.database().reference()
                let userRef = ref.child("users")
                let newUserRef = userRef.child("\(userData.username)\(datetoString(date: today))")

                let usermodel = ["steps": userData.Steps ,
                                 "distance": userData.distance ,
                                 "calories": userData.calories
                                ] as [String : Any]
                newUserRef.setValue(usermodel)
                
            }) {
                Text("Send today's data to cloud")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                
                userData.username = ""
                userData.name = ""
                userData.weight = 0.0
                userData.height = 0.0
                userData.image = UIImage()
                userData.dob = Date()
                userData.gender = ""
                userData.email = ""
                userData.Steps = 0
                userData.distance = 0.0
                userData.calories = 0
                userData.isUserLoggedIn = false
                
                navigateToSignUpView.toggle()
                
            }) {
                Text("LogOut")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
                }
        .fullScreenCover(isPresented: $navigateToSignUpView, content: {
            SignUpView()
        })
        
        
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
