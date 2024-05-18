//
//  FeedView.swift
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

struct FeedView: View {
    
    @State private var post1author: String = ""
    @State private var post1date: String = ""
    @State private var post1image: String = ""
    @State private var post1work: String = ""
    
    @State private var post2author: String = ""
    @State private var post2date: String = ""
    @State private var post2image: String = ""
    @State private var post2work: String = ""
    
    @State private var post3author: String = ""
    @State private var post3date: String = ""
    @State private var post3image: String = ""
    @State private var post3work: String = ""
    
    
    
    var body: some View {
        ScrollView{
            PostView(author: post1author, dateUploaded: post1date, work: post1work, imageURL: post1image)
            PostView(author: post2author, dateUploaded: post2date, work: post2work, imageURL: post2image)
            PostView(author: post3author, dateUploaded: post3date, work: post3work, imageURL: post3image)
            
        }
        .onAppear(perform: retrieveData)
        
    }
    
    func retrieveData(){
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog1/author").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post1author = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog1/work").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post1work = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog1/dateuploaded").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post1date = value
                                    
                                }
                            })
        }
        
        
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog2/author").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post2author = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog2/work").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post2work = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog2/dateuploaded").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post2date = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog3/author").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post3author = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog3/work").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post3work = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog3/dateuploaded").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post3date = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog1/imageurl").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post1image = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog2/imageurl").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post2image = value
                                    
                                }
                            })
        }
        
        if let user = Auth.auth().currentUser {
            let uid = user.uid
            let ref = Database.database().reference()
            ref.child("blogs/blog3/imageurl").observeSingleEvent(of: .value, with: { snapshot in
                                if let value = snapshot.value as? String {
                                    // If the retrieved data is a string, update the @State variable
                                    
                                    post3image = value
                                    
                                }
                            })
        }
        
        
        
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
