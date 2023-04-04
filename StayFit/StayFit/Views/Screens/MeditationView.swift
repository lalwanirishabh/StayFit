//
//  MeditationView.swift
//  StayFit
//
//  Created by Rishabh Lalwani on 04/04/23.
//

import SwiftUI
import AVFoundation

struct MeditationView: View {
    
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
            
            HStack(spacing: 20) {
                Button(action: {
                    audioPlayer.play()
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
    
//    var body: some View {
//        let audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: med, ofType: "mp3")!))
//
//        VStack {
//                    Button(action: {
//                        audioPlayer.play()
//                    }) {
//                        Image(systemName: "play.fill")
//                    }
//
//                    Button(action: {
//                        audioPlayer.pause()
//                    }) {
//                        Image(systemName: "pause.fill")
//                    }
//                }
//    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView(med: "med1")
    }
}
