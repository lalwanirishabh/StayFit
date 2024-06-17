//
//  DoctorSubView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 05/04/23.
//

import SwiftUI

struct DoctorSubView: View {
    
    let doc1availableDays: String
    let doc1availableTime: String
    let doc1education : String
    let doc1email: String
    let doc1experience: String
    let doc1imageUrl: String
    let doc1languages: String
    let doc1name: String
    let doc1rating : Int
    let doc1speciality: String
    let doc1username: String
    
    var body: some View {

        HStack {
                VStack{
                    RemoteImage(url: (URL(string: doc1imageUrl) ?? URL(string : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcs.m.wikipedia.org%2Fwiki%2FSoubor%3AGoogle_Images_2015_logo.svg&psig=AOvVaw24Ullz-5spo_zxeYWCBy5P&ust=1680765300328000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNiNk-eYkv4CFQAAAAAdAAAAABAD"))!)
                }
                .frame(height: 220,  alignment: .top)
            
            
            //
            VStack {
                
                HStack{
                    Text(" \(doc1name)")
                        .font(Font.custom("Helvetica", size: 20))
                    Spacer()
                }
                
                HStack{
                    Text(" \(doc1speciality)")
                    Spacer()
                    
                }
                
                Divider()
                
                HStack{
                    Text("\(Image(systemName: "person.badge.clock.fill"))  \(doc1experience) years exp")
                    Spacer()
                    
                }
                .padding(.bottom , 1)
                
                HStack{
                    Text(" \(Image(systemName: "speaker.fill"))  \(doc1languages)")
                        .font(Font.custom("Helvetica", size: 15))
                    Spacer()
                    
                }
                .padding(.bottom , 1)
                
                HStack{
                    Text("\(Image(systemName: "graduationcap.fill")) \(doc1education)")
                        .font(Font.custom("Helvetica", size: 15))
                        .padding(.bottom)
                    Spacer()
                    
                }
                
                HStack{
                    Text(" \(Image(systemName: "calendar")) \(doc1availableDays)")
                        .font(Font.custom("Helvetica", size: 15))
                    Spacer()
                    
                }
                
                HStack{
                    Text("  \(doc1availableTime)")
                        .font(Font.custom("Helvetica", size: 9))
                    Spacer()
                    
                }
                
                
            }
            
            VStack{
                
                Text("\(doc1rating) \(Image(systemName: "star.fill"))")
                
                Button(action: {
                    
                }) {
                    Text("Book Appointment")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct DoctorSubView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorSubView(doc1availableDays: "MON | THU | SAT", doc1availableTime: "10:00 AM - 12:00 AM | 4:00 PM - 06:00 PM", doc1education: "DMD, DDS", doc1email: "sumanthmbbs.", doc1experience: "7", doc1imageUrl: "https://firebasestorage.googleapis.com:443/v0/b/stayfit-64a79.appspot.com/o/images%2FUser83.jpg?alt=media&token=274ac1ef-6e33-4cae-99be-8c0b16862ce6", doc1languages: "English, Hindi, Telugu", doc1name: "Dr. Sumanth Shetty", doc1rating: 3, doc1speciality: "Dentist", doc1username: "drsumanth")
            .preferredColorScheme(.dark)
    }
}


