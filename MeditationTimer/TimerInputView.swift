//
//  TimerInputView.swift
//  playground-swiftui
//
//  Created by Joe Zoll on 9/23/23.
//

import SwiftUI

struct TimerInputView: View {
    // Choosing Meditation Session that carries into Timer View
    @StateObject var meditationSession =
    MeditationSession(
        minutesLeft: 0, secondsLeft: 0, isRunningTimer: false, isPresented: false
    )
    
    @State private var minutesLeft = 0
    @State private var secondsLeft = 0
    @State private var minutePercentage = 1.0
    @State private var isRunningTimer = false
    @State private var isShowingTimer = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Duration")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                // Hour, minute, second input
                HStack {
                    HStack {
                        Picker("Duration", selection: $minutesLeft) {
                            ForEach(0..<60, id: \.self) { minute in
                                Text("\(minute)")
                                    .foregroundColor(.white)
                            }
                        }
                        .pickerStyle(.wheel)
                        
                        Text("m")
                            .padding(.leading, -80)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Picker("Duration", selection: $secondsLeft) {
                            ForEach(0..<60, id: \.self) { second in
                                Text("\(second)")
                                    .foregroundColor(.white)
                            }
                        }
                        .pickerStyle(.wheel)
                        
                        Text("s")
                            .padding(.leading, -80)
                            .foregroundColor(.white)
                    }
                }
                
                // Save Button - Starts the Meditation
                Button {
                    isShowingTimer = true
                } label: {
                    ZStack {
                        Text("SAVE")
                            .foregroundColor(.black)
                            .background {
                                Ellipse()
                                    .fill(.white)
                            }
                    }
                }
                .sheet(isPresented: $isShowingTimer) {
//                    TimerView(minutesLeft: minutesLeft, secondsLeft: secondsLeft)
                    TimerView(meditationSession: meditationSession)
                }
            }
        }
    }
}

struct TimerInputView_Previews: PreviewProvider {
    static var previews: some View {
        TimerInputView()
    }
}
