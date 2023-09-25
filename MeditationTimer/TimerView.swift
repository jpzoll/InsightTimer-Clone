//
//  TimerView.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/24/23.
//

import SwiftUI
import AVKit

struct TimerView: View {
    // Meditation Session passed from TimerInput View
    @ObservedObject var meditationSession: MeditationSession
    @Environment(\.dismiss) var dismiss
    @State var soundManager = SoundManager()
    
    
    var timeString: String {
        var secondString = String(meditationSession.secondsLeft)
        var minuteString = String(meditationSession.minutesLeft) + ":"
        var hourString = String(meditationSession.hoursLeft) + ":"
        
        // Checking for single or double digit, and removing hour string if no necessary
        if meditationSession.secondsLeft < 10 { secondString = "0" + secondString }
        if meditationSession.minutesLeft < 10 { minuteString = "0" + minuteString }
        if meditationSession.hoursLeft < 10 { hourString = "0" + hourString }
        if meditationSession.hoursLeft == 0 { hourString = "" }
        
        return hourString + minuteString + secondString
        
    }
    
//    var timeString: String {
//        meditationSession.secondsLeft >= 10 ?
//             "\(meditationSession.minutesLeft):\(meditationSession.secondsLeft)" :
//                "\(meditationSession.minutesLeft):0\(meditationSession.secondsLeft)"
//    }
    
//    @State private var meditationSession.minutesLeft: Int
//    @State private var meditationSession.secondsLeft: Int
////    init(meditationSession.minutesLeft: Int, meditationSession.secondsLeft: Int) {
////        self.meditationSession.minutesLeft = meditationSession.minutesLeft
////        self.meditationSession.secondsLeft = meditationSession.secondsLeft
////    }
//
//    @State private var minutePercentage = 1.0
//    @State private var meditationSession.isRunningTimer = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text(timeString)
                .font(.system(size: 72))
                .fontWeight(.thin)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 30)
                .frame(maxWidth: 350, maxHeight: 300)
                .cornerRadius(20)
                .onReceive(timer) { _ in
                    
                    ///
                    // TIMER COUNTDOWN LOGIC
                    ///
                    if meditationSession.isRunningTimer {
                        if meditationSession.secondsLeft > 0 {
                    /// Decrement seconds if there are more than 0 seconds left
                            meditationSession.secondsLeft -= 1
                        } else if meditationSession.minutesLeft > 0 {
                    /// Decrement minutes and reset seconds to 59 when seconds reach 0
                            meditationSession.minutesLeft -= 1
                            meditationSession.secondsLeft = 59
                        } else if meditationSession.hoursLeft > 0 {
                    /// Decrement hours, reset minutes and seconds to 59 when minutes reach 0
                            meditationSession.hoursLeft -= 1
                            meditationSession.minutesLeft = 59
                            meditationSession.secondsLeft = 59
                        } else {
                    /// Timer and meditation are complete, **STOP** the timer!
                            meditationSession.isRunningTimer = false
                    ///
                    // END COUNTDOWN LOGIC
                    ///
                        }
                    }
                }
                Spacer()
                VStack {
                        
                        // Quit Session
                    VStack(spacing: 15) {
                        if !meditationSession.isRunningTimer {
                                Button("Discard Session") {
                                    dismiss()
                                    meditationSession.reset()
                                }
                                .textCase(.uppercase)
                                .font(.system(size: 15))
                                .padding()
                                .frame(width: 305, height: 45)
                                .foregroundColor(.white)
                                .background(.gray)
                                .cornerRadius(5)
                                
                                Button("Finish") {
                                    dismiss()
                                    meditationSession.reset()
                                }
                                .textCase(.uppercase)
                                .font(.system(size: 15))
                                .padding()
                                .frame(width: 305, height: 45)
                                .foregroundColor(.gray)
                                .background(.white)
                                .cornerRadius(5)
                            }
                        }
                        .frame(width: 250, height: 100)
                    VStack {
                        Button {
                            withAnimation(.linear(duration: 0.55)) {
                                meditationSession.isRunningTimer.toggle()
                            }
                        } label: {
                            Image(systemName: meditationSession.isRunningTimer ? "pause" : "play.fill")
                                .resizable()
                        }
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .onAppear {
            soundManager.playSound()
        }
    }
}

//struct TimerView_Previews: PreviewProvider {
//    @State var isPresented = false
//    static var previews: some View {
//        TimerView(meditationSession.minutesLeft: 5, meditationSession.secondsLeft: 0, isPresented: $isPresented)
//    }
//}
