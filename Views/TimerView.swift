//
//  TimerView.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/24/23.
//

import SwiftUI
import AVKit

struct TimerView: View {
    //
    // ➡️ 🧘‍♂️ Meditation Session passed from TimerInput View
    //
    @ObservedObject var meditationSession: MeditationSession
    @Environment(\.dismiss) var dismiss
    @State var soundManager = SoundManager()
    
    
    // ⏰ Computed Property for Time String
    var timeString: String {
        if meditationSession.warmupSeconds > 0 {
            var minuteString = "0" + ":"
            var secondString = String(meditationSession.warmupSeconds)
            if meditationSession.minutesLeft < 10 { minuteString = "0" + minuteString }
            if meditationSession.warmupSeconds < 10 { secondString = "0" + secondString }
            
            return minuteString + secondString
        } else {
            var secondString = String(meditationSession.secondsLeft)
            var minuteString = String(meditationSession.minutesLeft) + ":"
            var hourString = String(meditationSession.hoursLeft) + ":"
            
            // Checking for single or double digit, and removing hour string if not necessary
            if meditationSession.secondsLeft < 10 { secondString = "0" + secondString }
            if meditationSession.minutesLeft < 10 { minuteString = "0" + minuteString }
            if meditationSession.hoursLeft < 10 { hourString = "0" + hourString }
            if meditationSession.hoursLeft == 0 { hourString = "" }
            
            return hourString + minuteString + secondString
        }
    }
    
    //
    // ➡️ Timer Publisher
    //
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Spacer()
    
    //
    /// ⏰ **Time Text** - Shows time with updates every second
    //
                
                Text(timeString)
                    .font(.system(size: 72))
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 30)
                    .frame(maxWidth: 350, maxHeight: 300)
                    .cornerRadius(20)
                    .onReceive(timer) { _ in
            //
            // Countdown Logic with Timer
            //
                        if meditationSession.isRunningTimer {
                            if meditationSession.warmupSeconds > 0 {
                                meditationSession.warmupSeconds -= 1
                                if meditationSession.warmupSeconds <= 0 { soundManager.playSound() }
                            } else {
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
                                    soundManager.playSound2()
                                    meditationSession.isRunningTimer = false
            ///
            // END COUNTDOWN LOGIC
            ///
                                }
                            }
                        }
                    }
                Spacer()
                VStack {
        //
        /// ▫️ **Bottom Buttons**  - Change in style and visibility based on if meditation is paused or not
        //
                    VStack(spacing: 15) {
            //
            /// If paused, we have *Discard Session*, *Finish*, and *Play/Resume* Button
            //
                        if !meditationSession.isRunningTimer {
                            Button("Discard Session") {
                                dismiss()
                                meditationSession.resetToDefault()
                            }
                            .textCase(.uppercase)
                            .font(.system(size: 15))
                            .padding()
                            .frame(width: 305, height: 45)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(5)
                            
                            Button("Finish") {
                                meditationSession.resetToDefault()
                                dismiss()
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
                    
            //
            /// If playing, we have only the *pause* button
            //
                    
                    Button {
                        withAnimation(.linear(duration: 0.55)) {
                            if (meditationSession.secondsLeft > 0) || (meditationSession.minutesLeft > 0) || (meditationSession.hoursLeft > 0) {
                                meditationSession.isRunningTimer.toggle()
                            }
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
        /// Play sound and terminate warmup completely if there is none (0). Subtracting 1 prevents UI bug(s)
        .onAppear {
            if meditationSession.warmupSeconds == 0 {
                meditationSession.warmupSeconds -= 1
                soundManager.playSound()
            }
        }
    }
}


//struct TimerView_Previews: PreviewProvider {
//    @State var isPresented = false
//    static var previews: some View {
//        TimerView(meditationSession.minutesLeft: 5, meditationSession.secondsLeft: 0, isPresented: $isPresented)
//    }
//}
