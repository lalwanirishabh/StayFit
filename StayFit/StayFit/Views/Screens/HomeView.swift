//
//  HomeView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import HealthKit


struct HomeView: View {
    
    @State var progressValue: Double = 0.7
    @EnvironmentObject var userData : ViewModel
    
    private var healthStore : HealthStore?
    let calorieStore = HKHealthStore()
    let distanceStore = HKHealthStore()
    
    @State private var steps: [Step] = [Step]()
    
    
    init(){
        healthStore = HealthStore()
    }
    
    func greeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return "Good Morning"
        case 12..<18:
            return "Good Afternoon"
        default:
            return "Good Evening"
        }
    }
    
    private func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            steps.append(step)
            userData.Steps = step.count
        }
        
    }
    
    func fetchCalories(){
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let energyBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        calorieStore.requestAuthorization(toShare: nil, read: [energyBurnedType]) { success, error in
            // Handle the authorization result here.
        }
        
        let query = HKStatisticsQuery(quantityType: energyBurnedType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                // Handle the error here.
                return
            }
            
            let calories = Int(sum.doubleValue(for: HKUnit.kilocalorie()))
            print("calories = \(calories)")
            userData.calories = calories
            // Use the calories value here.
        }

        calorieStore.execute(query)
    }
    
    func fetchDistance(){
        print("distance function")
            let calendar = Calendar.current
            let now = Date()
            let startOfDay = calendar.startOfDay(for: now)
            let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
            
            let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            distanceStore.requestAuthorization(toShare: nil, read: [distanceType]) { success, error in
                // Handle the authorization result here.
            }

            let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { query, result, error in
                guard let result = result, let sum = result.sumQuantity() else {
                    // Handle the error here.
                    return
                }
                
                let distanceInMeters = sum.doubleValue(for: HKUnit.meter())
                let distanceInKilometers = distanceInMeters / 1000.0
                print("Distance = \(distanceInKilometers)")
                userData.distance = distanceInKilometers
            }

            distanceStore.execute(query)
        }
    
    
    var body: some View {
        ScrollView {
            VStack {
                GroupBox {
                    HStack {
                        Image(uiImage: userData.image!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 5)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text(greeting())
                                .font(.title3)
                            Text(userData.name)
                                .font(.title)
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .frame(height: 200)
                    .cornerRadius(10)
                    
                }
                .padding(.horizontal)
                .cornerRadius(10)
                
                
                
                
                VStack{
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                        
                        Circle()
                            .trim(from: 0.0, to: CGFloat(min(self.progressValue, Double(userData.Steps) / Double(userData.dailyStepsTarget))))
                            .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color("ColorGreen"))
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear)
                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                        
                        VStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Spacer()
                            Text("\(userData.Steps) \(Image(systemName: "shoeprints.fill"))")
                                .font(.title)
                                .foregroundColor(Color("ColorBlue"))
                            
                            Text("\(String(format: "%.1f", ((Double(userData.Steps) / 5000.0) * 100))) %")
                                .font(.title3)
                                .padding(.vertical)
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                }
                .padding()
                
                GroupBox{
                    HStack {
                        CardView(symbol: "figure.step.training", title: "Distance", value: "\(String(format: "%.2f", (userData.distance))) km")
                        CardView(symbol: "bolt.heart.fill", title: "Calories", value: "\(userData.calories) kcal")
                    }
                    .padding()
                    .cornerRadius(10)
                }
                .cornerRadius(10)
            }
            .cornerRadius(10)
            .onAppear {
                if let healthStore = healthStore {
                    healthStore.requestAuthorization { success in
                        if success {
                            healthStore.calculateSteps { statisticsCollection in
                                if let statisticsCollection = statisticsCollection {
                                    // update the UI
                                    updateUIFromStatistics(statisticsCollection)
                                    fetchCalories()
                                    fetchDistance()
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    
    
    
    struct CardView: View {
        var symbol : String
        var title: String
        var value: String
        
        var body: some View {
            VStack {
                HStack{
                    (Image(systemName: symbol))
                        .foregroundColor(Color("ColorGreen"))
                    Text(" \(title)")
                        .font(.headline)
                    //                    .font(.headline)
                }
//                Text("\(Image(systemName: symbol)) \(title)")
//                    .font(.headline)
                Divider()
                Text(value)
                    .font(.title)
                    .foregroundColor(Color("ColorBlue"))
            }
            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
