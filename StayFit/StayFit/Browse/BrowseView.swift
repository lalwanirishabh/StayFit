//
//  BrowseView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct BrowseView: View {
    
    
    
    var body: some View {
        List {
                        NavigationLink(destination: SelectMeditationView()) {
                            Text("Meditation")
                        }
                    NavigationLink(destination: BMIView(height: UserModel.instance.height, weight: UserModel.instance.weight)) {
                            Text("BMI")
                        }
                        NavigationLink(destination: ExerciseRoutineView()) {
                            Text("Exercise Routine")
                        }
                        NavigationLink(destination: WebView(url: URL(string: "https://www.eatingwell.com/recipes/18045/weight-loss-diet/")!)) {
                            Text("Recipes")
                        }
                        NavigationLink(destination: DoctorsView()) {
                            Text("Book an Appointment")
                        }
                    }
                    .navigationBarTitle("Categories")
                }
    }


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        return BrowseView().environmentObject(UserModel.instance)
            .preferredColorScheme(.dark)
    }
}
