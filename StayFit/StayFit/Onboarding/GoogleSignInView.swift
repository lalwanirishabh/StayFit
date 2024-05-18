//
//  GoogleSignInView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 07/05/24.
//

import SwiftUI

struct GoogleSignInView: View {
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
        }
    }
}

#Preview {
    GoogleSignInView()
}
