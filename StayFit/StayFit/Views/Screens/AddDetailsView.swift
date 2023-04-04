//
//  AddDetailsView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseStorage
import UIKit

struct AddDetailsView: View {
        
        @EnvironmentObject var userData : ViewModel
        @State private var name: String = ""
        @State private var gender: String = ""
        @State private var dateOfBirth: Date = Date()
        @State private var weight: Double = 0.0
        @State private var height: Double = 0.0
        @State private var image: UIImage?
        @State private var showImagePicker = false
        @State private var navigateToTabsView = false
        let storage = Storage.storage()
    
        let dateFormatter = DateFormatter()
    

    var body: some View {
        VStack {
            
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
            }
            
                    TextField("Name", text: $name)
                        .padding()
            
                    TextField("Gender", text: $gender)
                        .padding()
                    
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                        .padding()
                    
                    TextField("Weight", value: $weight, formatter: NumberFormatter())
                        .padding()
                        
                    
                    TextField("Height", value: $height, formatter: NumberFormatter())
                        .padding()
            
            
                    
                    Button(action: {
                        self.showImagePicker = true
                    }) {
                        Text("Choose Image")
                    }
                    .padding()
                    .sheet(isPresented: $showImagePicker) {
                                    ImagePicker(image: self.$image, isShown: self.$showImagePicker)
                                }
            
                    Button(action: {
                        
                        print(userData.username)
                        
                        userData.name = name
                        userData.dob = dateOfBirth
                        userData.weight = weight
                        userData.height = height
                        userData.image = image
                        userData.gender = gender
                        
                        if let imageData = image?.jpegData(compressionQuality: 0.5) {
                                            let storageRef = storage.reference()
                                            let imagesRef = storageRef.child("images")
                            let imageRef = imagesRef.child("\(userData.username).jpg")
                                            let metadata = StorageMetadata()
                                            metadata.contentType = "image/jpeg"
                                            imageRef.putData(imageData, metadata: metadata) { metadata, error in
                                                if let error = error {
                                                    print("Error uploading image: \(error.localizedDescription)")
                                                } else {
                                                    print("Image uploaded successfully!")
                                                }
                                            }
                                        }
                        
                        
                        
                        
                            // push the data to the Firebase Realtime Database
//                        let uid = "https://stayfit-64a79-default-rtdb.firebaseio.com/"
                            let ref = Database.database().reference()
                            let userRef = ref.child("users")
                        let newUserRef = userRef.child(userData.username)
                        
                            let usermodel = ["weight": weight ,
                                         "height": height ,
                                         "name": name ,
                                             "gender": gender ,
                                             "image" : "\(userData.username).jpg" ,
                                             "dob" : dateFormatter.string(from: dateOfBirth)
                        
                            ] as [String : Any]
                            newUserRef.setValue(usermodel)
//
                            
                        
//                            let userdob = ["dob": dateFormatter.string(from: dateOfBirth)]
//                            ref.setValue(userdob)
                        
                            
                        navigateToTabsView.toggle()
                        
                        
                            
                        
                            
                                
                        }) {
                            Text("Continue")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    
                }
        .fullScreenCover(isPresented: $navigateToTabsView, content: {
            TabsView()
        })
                
    }
    
    init() {
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
        }
}

struct AddDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddDetailsView()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var isShown: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                self.parent.image = selectedImage
            }
            self.parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.isShown = false
        }
    }
}
