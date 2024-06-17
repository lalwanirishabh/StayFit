//
//  MeditationView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import AVFoundation

struct MeditationView: View {
    
    @State var hours: String = ""
    @State var minutes: String = ""
    @State var seconds: String = ""
    @State var totalSeconds: Int = 0
    @State var countDownTimer: Int = 2
    @State var timerRunning = false
    
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let med: String
    @State private var isAnimating: Bool = false
    
    
    
    
    
    var body: some View {
        
        let audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: med, ofType: "mp3")!))
        
        
        VStack(spacing: 20) {
            // MARK: - HEADER
            
            Spacer()
            
            ZStack {
                CircleGroupView(ShapeColor: .gray, ShapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(
                        Animation
                            .easeInOut(duration: 4)
                            .repeatForever()
                        , value: isAnimating
                    )
            }
            
//            HStack {
//                        TextField("Hours", text: $hours)
//                            .textFieldStyle(.roundedBorder)
//                            .keyboardType(.numberPad)
//                            .frame(width: 50)
//                        TextField("Minutes", text: $minutes)
//                            .textFieldStyle(.roundedBorder)
//                            .keyboardType(.numberPad)
//                            .frame(width: 50)
//                        TextField("Seconds", text: $seconds)
//                            .textFieldStyle(.roundedBorder)
//                            .keyboardType(.numberPad)
//                            .frame(width: 50)
//                    }
//                    .padding()
            
//            Text("\(countDownTimer)")
//                .onReceive(timer){ _ in
//                    if countDownTimer > 0 && timerRunning{
//                        countDownTimer -= 1
//                    }else{
//                        timerRunning = false
//                    }
//                }
            
            HStack(spacing: 20) {
                Button(action: {
                    totalSeconds += ((Int(hours) ?? 0)*60*60)
                    totalSeconds += ((Int(minutes) ?? 0)*60)
                    totalSeconds += ((Int(seconds) ?? 0))
                    audioPlayer.play()
                    hours = ""
                    minutes = ""
                    seconds = ""
                    audioPlayer.play()
                    timerRunning = true
                    Timer.scheduledTimer(withTimeInterval: TimeInterval(totalSeconds), repeats: false) { _ in
                            // Code to execute when the timer is finished
                        }
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Button(action: {
                    audioPlayer.pause()
                }) {
                    HStack {
                        Image(systemName: "pause.fill")
                            .foregroundColor(.white)
                        Text("Pause")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }

            
            Spacer()
            
        }
        
    //: VSTACK
      .onAppear(perform: {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
          isAnimating = true
        })
      })
    }
    
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView(med: "med1")
            .preferredColorScheme(.dark)
    }
}
