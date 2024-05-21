//
//  OTPView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 19/05/24.
//

import SwiftUI

struct OTPView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @State var naviagteToAddDetialsView = false
    @Environment(\.dismiss) private var dismiss
    @State var otpString: String = ""
    var characterLimit = 6
    @State var countrySelection: Country = Country.india
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    upperView()
                    Spacer()
                    lowerView()
                }
                .padding(.horizontal, 25)
                .frame(minHeight: geometry.size.height)
            }
            .navigationBarBackButtonHidden()
            .scrollDisabled(true)
            .frame(width: geometry.size.width)
        }
    }
    
    private func upperView() -> some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image("CaretLeft")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding(.leading, 5)
                }
                Spacer()
            }
            .padding(.bottom, 30)
            
            HStack {
                Text("Enter OTP")
                    .font(.custom("Poppins-Bold", size: 30))
                    .padding(.leading, 15)
                Spacer()
            }
            .padding(.bottom, 3)
            
            HStack {
                Text("Enter your OTP sent to " + UserModel.instance.phoneNumber.prefix(4) + " XXXX XX")
                    .font(.custom("Poppins-Medium", size: 15))
                    .padding(.leading, 15)
                Spacer()
            }
            .padding(.bottom, 100)
            
            optField()
                .padding(.bottom, 90)
            
            Button {
                authViewModel.selectedCountryCode = countries[countrySelection.rawValue] ?? ""
                authViewModel.sendCode()
            } label: {
                Text("Resend OTP")
                    .foregroundColor(.black)
                    .font(.custom("Poppins-Medium", size: 15))
            }
            
        }
    }
    
    @ViewBuilder
    private func lowerView() -> some View {
        Button {
            if isValidOtp(code: otpString) {
                authViewModel.codeFromUser = otpString
                authViewModel.verifyCode() { userExist in
                    if userExist {
                        UserDefaults.standard.set(true, forKey: UserDefaultKeys.isLoggedIn)
                    } else {
                        self.naviagteToAddDetialsView = true
                    }
                }
                print("user signed up as  \(UserModel.instance.username) \(UserModel.instance.username)")
            }
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .frame(height: 81)
                .padding(.horizontal, 16)
                .overlay {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 15))
                }
                .shadow(radius: 5, y: 5)
        }
    }
    
    @ViewBuilder
    private func optField() -> some View {
        ZStack {
            HStack {
                otpBubble(with: otpString.count >= 1 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 0)]) : "")
                otpBubble(with: otpString.count >= 2 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 1)]) : "")
                otpBubble(with: otpString.count >= 3 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 2)]) : "")
                otpBubble(with: otpString.count >= 4 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 3)]) : "")
                otpBubble(with: otpString.count >= 5 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 4)]) : "")
                otpBubble(with: otpString.count >= 6 ? String(otpString[otpString.index(otpString.startIndex, offsetBy: 5)]) : "")
            }
            
            TextField("", text: $otpString)
                .font(.custom("Poppins-light", size: 15))
                .foregroundColor(Color(hex: "90FFB6"))
                .frame(height: 60)
                .opacity(0.1)
                .tint(.clear)
                .onReceive(otpString.publisher.collect()) {
                    let s = String($0.prefix(characterLimit))
                    if otpString != s {
                        otpString = s
                    }
                }
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .autocapitalization(.none)
        }
    }
    
    @ViewBuilder
    private func otpBubble(with text: String) -> some View {
        Circle()
            .foregroundColor(Color(hex: "90FFB6"))
            .frame(width: 56, height: 56)
            .overlay {
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color(hex: "20DC60"))
                    .overlay {
                        Text(text)
                            .font(.custom("Poppins-Medium", size: 21))
                            .foregroundColor(.black)
                    }
            }
    }
    
    func isValidOtp(code: String) -> Bool {
        code.count  ==  6 && code.isNumber   ? true : false
    }
}

#Preview {
    OTPView()
        .environmentObject(AuthenticationViewModel())
        .environmentObject(UserModel())
}
