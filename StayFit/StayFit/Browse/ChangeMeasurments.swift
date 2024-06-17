//
//  ChangeMeasurments.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 05/04/23.
//

import SwiftUI
import Firebase
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseStorage
    

struct ChangeMeasurmentsView: View {
    
    @State private var navigateToAddDetailsView = false
    @State var weight: Double = 0 // initialize to 0
    @State var height: Double = 0 // initialize to 0
    
    
    var body: some View {
        VStack {
                    Text("Enter Your Details")
                        .font(.largeTitle)
                        .padding()

                    HStack {
                        Text("Weight (kg):")
                            .padding(.trailing)
                        Text(String(format: "%.0f", weight))
                            .font(.title)
                        Spacer()

                            Picker("", selection: $weight) {
                                ForEach(0..<200) { index in
                                    Text("\(index)").tag(Double(index))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 150, height: 150)
                    }
                    .padding()

                    HStack {
                        Text("Height (cm):")
                            .padding(.trailing)
                        Text(String(format: "%.0f", height))
                            .font(.title)
                        Spacer()
                            Picker("", selection: $height) {
                                ForEach(0..<300) { index in
                                    Text("\(index)").tag(Double(index))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 150, height: 150)
                    }
                    .padding()

                    Button(action: {
                        UserModel.instance.weight = weight
                        UserModel.instance.height = height
                        
                        navigateToAddDetailsView.toggle()
                    }) {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding()
                }
        .fullScreenCover(isPresented: $navigateToAddDetailsView, content: {
            TabsView()
        })
    }
    
    func sendDatatoCloud(){
        let ref1 = Database.database().reference(withPath: "users/\(UserModel.instance.username)/weight")
        ref1.setValue(UserModel.instance.weight) { (error, ref1) in
          if let error = error {
            print("Error writing to database: \(error.localizedDescription)")
          } else {
            print("Data written successfully!")
          }
        }
        
        let ref2 = Database.database().reference(withPath: "users/\(UserModel.instance.username)/height")
        ref2.setValue(UserModel.instance.height) { (error, ref1) in
          if let error = error {
            print("Error writing to database: \(error.localizedDescription)")
          } else {
            print("Data written successfully!")
          }
        }
    }
}

struct ChangeMeasurments_Previews: PreviewProvider {
    static var previews: some View {
        ChangeMeasurmentsView()
            .preferredColorScheme(.dark)
    }
}
