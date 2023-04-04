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

    
    @State private var steps: [Step] = [Step]()
    
    
    init(){
        healthStore = HealthStore()
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
    
    
    var body: some View {
        ScrollView {
            
            GroupBox{
                HStack {
                    Image(uiImage: userData.image!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 5)
                    
                    VStack(alignment: .leading) {
                        Text("Good morning")
                            .font(.title3)
                        Text("Mr. \(userData.name)")
                            .font(.title)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            
            
            
            
            
            
            GroupBox{
                ZStack {
                    Circle()
                        .stroke(lineWidth: 10)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progressValue, Double(userData.Steps)/5000.0)))
                        .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.green)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear)
                        .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                    
                    VStack {
                        Text("\(userData.Steps)")
                            .font(.title3)
                        Text("\((Int(Double(userData.Steps)/5000.0) * 100))%")
                            .font(.title)
                    }
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.width / 2)
                
                
            }
            
            
            HStack {
                CardView(title: "Distance", value: "distance km")
                CardView(title: "Calories", value: "120 kcal")
            }
            .padding()
            
            HStack {
                CardView(title: "Minutes", value: "15 min")
            }
            .padding()
            
            
        }
        .onAppear {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    if success {
                        
                        healthStore.calculateSteps { statisticsCollection in
                            if let statisticsCollection = statisticsCollection {
                                // update the UI
                                updateUIFromStatistics(statisticsCollection)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    struct CardView: View {
        var title: String
        var value: String
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Text(value)
                    .font(.title)
                    .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.width/2)
            .background(Color.white)
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
