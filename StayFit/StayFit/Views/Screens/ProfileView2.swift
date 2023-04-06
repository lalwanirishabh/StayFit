//
//  ProfileView2.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 05/04/23.
//

import SwiftUI
import HealthKit
import Firebase
import FirebaseDatabase
import FirebaseCore
import FirebaseAuth
import URLImage
import FirebaseStorage

struct ProfileView2: View {
    
    let name : String
    let username : String
    let email : String
    let image : UIImage
    
    @EnvironmentObject var userData : ViewModel
    @State private var navigateToSignUpView = false
    let today = Date()
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Image(uiImage : image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 7)
            
            Text(name)
                .font(.title)
                .padding(.top)
            
            Text("@\(username)")
                        .font(.title2)
            
            Spacer()
            
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
            
            Button(action: {
                
            }) {
                Text("Change Password")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            VStack {
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
            }
            .padding(.bottom , 30)
            
            
        }
        .fullScreenCover(isPresented: $navigateToSignUpView, content: {
            SignUpView()
        })
    }
    
    func datetoString(date : Date) -> String{
        let dateFormatter = DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        let dateString = formatter.string(from: today)
        return dateString
    }
}

struct ProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView2(name: "Rishabh" , username: "_lalwanirishabh" , email: "rishabhlalwani1048@gmail.com", image: UIImage(named: "character-2")!)
            .preferredColorScheme(.dark)
    }
}
