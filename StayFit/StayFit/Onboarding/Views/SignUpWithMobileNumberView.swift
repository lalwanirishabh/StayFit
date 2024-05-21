//
//  SignUpWithMobileNumberView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 19/05/24.
//

import SwiftUI

struct SignUpWithMobileNumberView: View {
    @Environment(\.dismiss) private var dismiss
    @State var countrySelection: Country = Country.india
    @State var phoneNumber: String = ""
    @StateObject var authViewModel = AuthenticationViewModel()
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    upperView()
                    Spacer()
                    lowerView()
                }
                .fullScreenCover(isPresented: $authViewModel.goToVerify, content: {
                    OTPView()
                        .environmentObject(authViewModel)
                })
                .navigationBarBackButtonHidden(true)
                .padding(.horizontal, 25)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("CaretLeft")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("Log In")
                            .font(.custom("Poppins-Bold", size: 15))
                        
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
            .scrollDisabled(true)
            .frame(width: geometry.size.width)
        }
    }
    
    @ViewBuilder
    private func upperView() -> some View {
        VStack {
            HStack {
                Text("Sign Up")
                    .font(.custom("Poppins-Bold", size: 30))
                Spacer()
            }
            .padding(.top, 30)
            .padding(.bottom, 11)

            HStack {
                Text("Signup to a new world. You can hide this from your profile later.")
                    .font(.custom("Poppins-Medium", size: 15))
                Spacer()
            }
            .padding(.bottom, 100)

            HStack {
                Menu {
                    Picker("Select Country", selection: $countrySelection) {
                        ForEach(Country.allCases, id: \.self) { value in
                            Text("\(countryFlag(countryCode: value.abbreviation ?? "")) \(value.name)    +\(countries[value.rawValue] ?? "")")
                                .tag(value)
                        }
                    }
                    .pickerStyle(.menu)
                } label: {

                    Circle()
                        .foregroundColor(Color(hex: "E9E9E9"))
                        .frame(width: 59, height: 59)
                        .overlay {
                            Text("+\(countries[countrySelection.rawValue] ?? "")")
                                .foregroundColor(.black)
                                .font(.custom("Poppins-Medium", size: 15))
                        }
                }

                TextField("", text: $phoneNumber, prompt: Text("Mobile").foregroundColor(.black).font(.custom("Poppins-Medium", size: 15)))
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .padding(.horizontal, 25)
                    .font(.custom("Poppins-Medium", size: 18))
                    .keyboardType(.numberPad)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color(hex: "E9E9E9"))
                    }
                    .onChange(of: phoneNumber) { newValue in
                        UserModel.instance.phoneNumber = "+\(countries[countrySelection.rawValue] ?? "")\(newValue)"
                    }
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
        }
    }

    @ViewBuilder
    private func lowerView() -> some View {
        Button {
            UserModel.instance.phoneNumber = phoneNumber
            authViewModel.selectedCountryCode = countries[countrySelection.rawValue] ?? ""
            authViewModel.sendCode()
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .frame(height: 81)
                .overlay {
                    Text("Continue")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 15))
                }
                .shadow(radius: 5, y: 5)
        }
    }
}

#Preview {
    SignUpWithMobileNumberView()
}
