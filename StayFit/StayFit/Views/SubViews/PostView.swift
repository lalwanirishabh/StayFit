//
//  PostView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 05/04/23.
//

import SwiftUI

struct PostView: View {
    
    let author : String
    let dateUploaded : String
    let work : String
    let imageURL : String
    
    

    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
                    

                    HStack {
                        
                        RemoteImage(url: (URL(string: imageURL) ?? URL(string : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fcs.m.wikipedia.org%2Fwiki%2FSoubor%3AGoogle_Images_2015_logo.svg&psig=AOvVaw24Ullz-5spo_zxeYWCBy5P&ust=1680765300328000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCNiNk-eYkv4CFQAAAAAdAAAAABAD"))!)
                        
                        Text(author)
                            .font(.headline)
                        Spacer()
                        Text(dateUploaded)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

            Text(work)
                .font(.caption)
                .foregroundColor(.white)
                .lineLimit(nil)
                }
                .padding()
                .background(Color.black)
                .cornerRadius(10)
                .shadow(radius: 5)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(author: "Dr. Smith", dateUploaded: "9 Mar, 2023", work: "Health is a state of complete physical, mental, and social well-being, and not merely the absence of disease or infirmity. It is an essential aspect of our lives and is crucial for our overall well-being. Good health is not just about being physically fit; it also includes mental, emotional, and social well-being.  To maintain good health, we need to follow a healthy lifestyle, which includes eating a balanced diet, regular exercise, getting enough sleep, and managing stress. Eating a balanced diet is essential for our health as it provides us with the necessary nutrients to keep our body functioning correctly. Exercise is also crucial as it helps to keep us physically fit and reduces the risk of chronic diseases such as heart disease, diabetes, and obesity. Getting enough sleep is vital for our body to recover and repair itself, and managing stress is essential to avoid mental health issues such as anxiety and depression.  In today's fast-paced world, it can be challenging to maintain a healthy lifestyle. However, we can make small changes to our daily routine that can have a significant impact on our health. For example, taking a brisk walk for 30 minutes a day, reducing our intake of processed foods, and practicing relaxation techniques such as meditation or yoga.  In addition to a healthy lifestyle, regular check-ups with a healthcare provider are also essential to maintain good health. It is important to get regular screenings and tests to detect any health issues early on, when they are easier to treat.  In conclusion, good health is essential for our overall well-being. By following a healthy lifestyle, getting regular check-ups, and making small changes to our daily routine, we can maintain good health and prevent chronic diseases. Remember, a healthy lifestyle is not a goal; it is a journey that we need to continue throughout our lives to enjoy the benefits of good health.", imageURL: "https://firebasestorage.googleapis.com/v0/b/stayfit-64a79.appspot.com/o/images%2Fab80d763-d65a-46d6-9477-1e31f6456243.jpg?alt=media&token=db18201e-3bb5-4928-8fc4-5de4a0d8a651")
    }
        
}


struct RemoteImage: View {
    let url: URL
    
    var body: some View {
        Group {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
        }
    }
}



