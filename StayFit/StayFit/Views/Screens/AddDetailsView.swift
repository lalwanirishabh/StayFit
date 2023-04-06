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
        @State private var weight: Double = 75.0
        @State private var height: Double = 170.0
        @State private var dailyStepsTarget: Int = 50
        @State private var image: UIImage?
        @State private var showImagePicker = false
        @State private var navigateToTabsView = false
        let storage = Storage.storage()
    
        let dateFormatter = DateFormatter()
    
    func datetoString(today : Date) -> String{
        let dateFormatter = DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy"
        let dateString = formatter.string(from: today)
        return dateString
    }
    

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
                .padding(.horizontal)
                    
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    .padding(.horizontal)
            
                    HStack {
                        Text("Weight (kg):")
                            .padding(.trailing)
                        Text(String(format: "%.0f", weight))
                            .font(.title)
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                            Picker("", selection: $weight) {
                                ForEach(0..<200) { index in
                                    Text("\(index)").tag(Double(index))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        .frame(width: 100, height: 80)
                        Spacer()
                    }
                    .padding(.horizontal)
            
                HStack {
                    Text("Height (cm):")
                        .padding(.trailing)
                    Text(String(format: "%.0f", height))
                        .font(.title)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                        Picker("", selection: $height) {
                            ForEach(0..<200) { index in
                                Text("\(index)").tag(Double(index))
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    
                    .frame(width: 100, height: 80)
                    Spacer()
                }
                .padding(.horizontal)
            
            HStack {
                Text("Daily Steps Target")
                    .padding(.trailing)
                Text(String(format: "%.0f", dailyStepsTarget))
                    .font(.title)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Picker("", selection: $dailyStepsTarget) {
                    ForEach(1...250, id: \.self) { index in
                        let value = index * 100
                        Text("\(value)").tag(Double(value))
                    }
                }
                    .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 80)
                Spacer()
            }
            .padding(.horizontal)
                    
            
                    
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
                        userData.dailyStepsTarget = dailyStepsTarget*100
                        
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
                                                    imageRef.downloadURL { (url, error) in
                                                            guard let downloadURL = url else { return }
                                                            let imageUrl = downloadURL.absoluteString
                                                        print("\(imageUrl)")
                                                        userData.imageUrl = String(imageUrl)
                                                        print(userData.imageUrl)
                                                        sendData()
                                                        }
                                                    print("Image uploaded successfully!")
                                                    
                                                }
                                            }
                                        }
                        
                        func sendData(){
                            let ref = Database.database().reference()
                            let userRef = ref.child("users")
                        let newUserRef = userRef.child(userData.username)
                        
                            let usermodel = ["weight": weight ,
                                         "height": height ,
                                         "name": name ,
                                             "gender": gender ,
                                             "imageUrl" : userData.imageUrl ,
                                             "dob" : Int(datetoString(today: userData.dob))! ,
                                            "email" : userData.email,
                                             "username" : userData.username,
                                             "dailyStepsTarget" : userData.dailyStepsTarget
                                             
                        
                            ] as [String : Any]
                            newUserRef.setValue(usermodel)
                        }
                        
                            

                            
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
            .preferredColorScheme(.dark)
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
