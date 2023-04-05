//
//  BMIView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI

struct BMIView: View {
    
    let height: Double
    let weight: Double
    
    @State private var navigateToAddDetailsView = false
    
    var body: some View {
        let bmi = calculateBMI()
                
    VStack {
                    Text("Your BMI")
                        .font(.title)
                    
                    Text(String(format: "%.1f", bmi))
                        .font(.system(size: 72, weight: .bold, design: .default))
                    
                    Text(getBMIStatus())
                        .font(.title2)
                    
                    Button(action: {
                        
                        navigateToAddDetailsView.toggle()
                        
                    }) {
                        Text("Change Details")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .fullScreenCover(isPresented: $navigateToAddDetailsView, content: {
                    ChangeMeasurmentsView()
                })
        
    }
        
    
    func calculateBMI() -> Double {
            let heightInMeters = height / 100.0
            return weight / (heightInMeters * heightInMeters)
        }
        
        func getBMIStatus() -> String {
            
            let bmi = calculateBMI()
            
            if bmi < 18.5 {
                return "Underweight"
            } else if bmi < 25 {
                return "Normal weight"
            } else if bmi < 30 {
                return "Overweight"
            } else {
                return "Obese"
            }
        }
}

struct BMIView_Previews: PreviewProvider {
    static var previews: some View {
        BMIView(height: 170, weight: 75)
    }
}
