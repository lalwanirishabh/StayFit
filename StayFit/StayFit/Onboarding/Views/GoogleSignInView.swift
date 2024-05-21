//
//  GoogleSignInView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 07/05/24.
//

import SwiftUI

struct GoogleSignInView: View {
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State var naviagteToAddDetialsView = false
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
            .sheet(isPresented: $naviagteToAddDetialsView) {
                AddDetailsView()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2))
            .onTapGesture {
                authVM.signInWithGoogle { userExists in
                    if userExists {
                        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                    } else {
                        self.naviagteToAddDetialsView = true
                    }
                }
            }
        }
    }
}

#Preview {
    GoogleSignInView()
}
