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
    //MARK: - VARIABLES
    let name : String
    let username : String
    let email : String
    let image : UIImage
    @State private var navigateToSignUpView = false
    let today = Date()
    //MARK: - BODY
    var body: some View {
        VStack{
            Spacer()
            //MARK: - PROFILEIMAGE&NAME
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
            //MARK: - LOGOUTBUTTON
            Button(action: {
                UserModel.instance.username = ""
                UserModel.instance.name = ""
                UserModel.instance.weight = 0.0
                UserModel.instance.height = 0.0
                UserModel.instance.image = UIImage()
                UserModel.instance.dob = Date()
                UserModel.instance.gender = ""
                UserModel.instance.email = ""
                UserModel.instance.Steps = 0
                UserModel.instance.distance = 0.0
                UserModel.instance.calories = 0
                UserModel.instance.isUserLoggedIn = false
                navigateToSignUpView.toggle()
            }) {
                Text("LogOut")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
            
            //MARK: - CHANGEPASSBUTTON
            Button(action: {
                
            }) {
                Text("Change Password")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            
            VStack {
                
                //MARK: - DATACLOUDBUTTON
                Button(action: {
                    let ref = Database.database().reference()
                    let userRef = ref.child("users")
                    let newUserRef = userRef.child("\(UserModel.instance.username)\(datetoString(date: today))")

                    let usermodel = ["steps": UserModel.instance.Steps ,
                                     "distance": UserModel.instance.distance ,
                                     "calories": UserModel.instance.calories
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
    
    
    //MARK: - FUNCTIONS
    func datetoString(date : Date) -> String{
        let dateFormatter = DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        let dateString = formatter.string(from: today)
        return dateString
    }
}

//MARK: - PREVIEW
struct ProfileView2_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView2(name: "Rishabh" , username: "_lalwanirishabh" , email: "rishabhlalwani1048@gmail.com", image: UIImage(named: "character-2")!)
            .preferredColorScheme(.dark)
    }
}
