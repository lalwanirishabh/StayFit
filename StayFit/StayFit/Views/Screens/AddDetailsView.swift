//
//  AddDetailsView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import UIKit

struct AddDetailsView: View {
    
    @State private var name: String = ""
        @State private var dateOfBirth: Date = Date()
        @State private var weight: Double = 0.0
        @State private var height: Double = 0.0
        @State private var image: UIImage?
        @State private var showImagePicker = false
    

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
                    
                }
                .navigationBarTitle("User Info")
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
