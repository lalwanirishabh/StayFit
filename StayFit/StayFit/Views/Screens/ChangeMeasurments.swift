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
    
    @EnvironmentObject var userData : ViewModel
    
    var body: some View {
        VStack {
                    Text("Enter Your Details")
                        .font(.largeTitle)
                        .padding()

                    HStack {
                        Text("Weight (kg):")
                            .padding(.trailing)
                        Text(String(format: "%.1f", weight))
                            .font(.title)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            Picker("", selection: $weight) {
                                ForEach(0..<200) { index in
                                    Text("\(index)").tag(Double(index))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        .frame(width: 150, height: 150)
                    }
                    .padding()

                    HStack {
                        Text("Height (cm):")
                            .padding(.trailing)
                        Text(String(format: "%.1f", height))
                            .font(.title)
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            Picker("", selection: $height) {
                                ForEach(0..<300) { index in
                                    Text("\(index)").tag(Double(index))
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                        }
                        .frame(width: 150, height: 150)
                    }
                    .padding()

                    Button(action: {
                        userData.weight = weight
                        userData.height = height
                        
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
        let ref1 = Database.database().reference(withPath: "users/\(userData.username)/weight")
        ref1.setValue(userData.weight) { (error, ref1) in
          if let error = error {
            print("Error writing to database: \(error.localizedDescription)")
          } else {
            print("Data written successfully!")
          }
        }
        
        let ref2 = Database.database().reference(withPath: "users/\(userData.username)/height")
        ref2.setValue(userData.height) { (error, ref1) in
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
