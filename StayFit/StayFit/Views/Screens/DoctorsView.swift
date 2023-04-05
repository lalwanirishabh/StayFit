//
//  DoctorsView.swift
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

struct DoctorsView: View {
    
    @State private var doc1availableDays: String = ""
    @State private var doc1availableTime: String = ""
    @State private var doc1education : String = ""
    @State private var doc1email: String = ""
    @State private var doc1experience: String = ""
    @State private var doc1imageUrl: String = ""
    @State private var doc1languages: String = ""
    @State private var doc1name: String = ""
    @State private var doc1rating : Int = 0
    @State private var doc1speciality: String = ""
    @State private var doc1username: String = ""
    
    @State private var doc2availableDays: String = ""
    @State private var doc2availableTime: String = ""
    @State private var doc2education : String = ""
    @State private var doc2email: String = ""
    @State private var doc2experience: String = ""
    @State private var doc2imageUrl: String = ""
    @State private var doc2languages: String = ""
    @State private var doc2name: String = ""
    @State private var doc2rating : Int = 0
    @State private var doc2speciality: String = ""
    @State private var doc2username: String = ""
    
    
    var body: some View {
        ScrollView{
            GroupBox{
                DoctorSubView(doc1availableDays: doc1availableDays, doc1availableTime: doc1availableTime, doc1education: doc1education, doc1email: doc1email, doc1experience: doc1experience, doc1imageUrl: doc1imageUrl, doc1languages: doc1languages, doc1name: doc1name, doc1rating: doc1rating, doc1speciality: doc1speciality, doc1username: doc1username)
            }
            
        }
        .onAppear(perform: retrieveData)
    }
    
    func retrieveData(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/availableDays").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1availableDays = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/availableDays").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2availableDays = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/availableTime").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1availableTime = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/availableTime").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2availableTime = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/education").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1education = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/education").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2education = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/email").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1email = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/email").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2email = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/experience").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1experience = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/experience").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2experience = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/imageurl").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1imageUrl = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/imageurl").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2imageUrl = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/languages").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1languages = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/languages").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2languages = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/name").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1name = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/name").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2name = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/rating").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Int {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1rating = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/rating").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? Int {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2rating = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/speciality").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1speciality = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/speciality").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2speciality = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc1/username").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc1username = value
                    
                }
            })
        }//end
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("doctors/doc2/username").observeSingleEvent(of: .value, with: { snapshot in
                if let value = snapshot.value as? String {
                    // If the retrieved data is a string, update the @State variable
                    
                    doc2username = value
                    
                }
            })
        }//end
        
        
        
        
        
        
    }
        
        
        
        
    }


struct DoctorsView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorsView()
            .preferredColorScheme(.dark)
    }
}
