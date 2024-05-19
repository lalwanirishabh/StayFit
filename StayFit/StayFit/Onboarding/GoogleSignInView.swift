//
//  GoogleSignInView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 07/05/24.
//

import SwiftUI

struct GoogleSignInView: View {
    @StateObject var googleSignInVM = GoogleSignInViewModel()
    @State private var navigateToTabsView = false
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("Google")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                Text("Continue with Google")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .padding(.vertical)
                Spacer()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2))
            .onTapGesture {
                googleSignInVM.signInWithGoogle { result in
                    if result {
                        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                        navigateToTabsView.toggle()
                    } else {
                        
                    }
                }
            }
            .fullScreenCover(isPresented: $navigateToTabsView) {
                TabsView()
            }
        }
    }
}

#Preview {
    GoogleSignInView()
}
