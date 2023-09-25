//
//  TimerView.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/24/23.
//

import SwiftUI

struct TimerView: View {
    // Meditation Session passed from TimerInput View
    @ObservedObject var meditationSession: MeditationSession
    
    @State private var minutesLeft: Int
    @State private var secondsLeft: Int
//    init(minutesLeft: Int, secondsLeft: Int) {
//        self.minutesLeft = minutesLeft
//        self.secondsLeft = secondsLeft
//    }
    
    @State private var minutePercentage = 1.0
    @State private var isRunningTimer = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                Text(secondsLeft >= 10 ?
                     "\(minutesLeft):\(secondsLeft)" :
                        "\(minutesLeft):0\(secondsLeft)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 30)
                .frame(width: 95, height: 50)
                .cornerRadius(20)
                .onReceive(timer) { _ in
                    if isRunningTimer && (minutesLeft >= 0) && (secondsLeft > 0) {
                        secondsLeft -= 1
                    } else if isRunningTimer && (minutesLeft > 0) {
                        minutesLeft -= 1
                        secondsLeft = 59
                    } else {
                        isRunningTimer = false
                    }
                }
                VStack(spacing: 20) {
                    if !isRunningTimer {
//                        Button {
//                            if isRunningTimer {
//                                isRunningTimer = false
//                            } else {
//                                minutesLeft = 5
//                                secondsLeft = 0
//                            }
//                        } label: {
//                            Image(systemName: isRunningTimer ? "pause" : "circle.fill")
//                        }
                        
                        // Quit Session
                        VStack(spacing: 10) {
                            Button("Discard Session") {
                                print("discard")
                            }
                            .textCase(.uppercase)
                            .font(.caption)
                            .padding()
                            .frame(width: 200, height: 40)
                            .foregroundColor(.white)
                            .background(.gray)
                            Button("Finish") {
                            }
                            .textCase(.uppercase)
                            .font(.caption)
                            .padding()
                            .frame(width: 200, height: 40)
                            .foregroundColor(.gray)
                            .background(.white)
                        }
                    }
                    Button {
                        withAnimation(.easeIn) {
                            isRunningTimer.toggle()
                        }
                    } label: {
                        Image(systemName: isRunningTimer ? "pause" : "play")
                    }
                    .foregroundColor(.white)
//                    Button("Accelerate") {
//                        if secondsLeft > 10 {
//                            secondsLeft -= 10
//                        }
//                    }
                }
            }
        }
    }
}

//struct TimerView_Previews: PreviewProvider {
//    @State var isPresented = false
//    static var previews: some View {
//        TimerView(minutesLeft: 5, secondsLeft: 0, isPresented: $isPresented)
//    }
//}
