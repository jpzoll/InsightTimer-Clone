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
        hoursLeft: 0, minutesLeft: 0, secondsLeft: 10, isRunningTimer: false, isPresented: false
    )
    
    @State private var minutesLeft = 0
    @State private var secondsLeft = 10
    @State private var minutePercentage = 1.0
    @State private var isRunningTimer = false
    @State private var isShowingTimer = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
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
                            Picker("Duration", selection: $meditationSession.hoursLeft) {
                                ForEach(0..<60, id: \.self) { hour in
                                    Text("\(hour)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Text("h")
                                .padding(.leading, -50)
                                .foregroundColor(.white)
                        }
                        HStack {
                            Picker("Duration", selection: $meditationSession.minutesLeft) {
                                ForEach(0..<60, id: \.self) { minute in
                                    Text("\(minute)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Text("m")
                                .padding(.leading, -50)
                                .foregroundColor(.white)
                        }
                        HStack {
                            Picker("Duration", selection: $meditationSession.secondsLeft) {
                                ForEach(0..<60, id: \.self) { second in
                                    Text("\(second)")
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            
                            Text("s")
                                .padding(.leading, -50)
                                .foregroundColor(.white)
                        }
                    }
                    .sheet(isPresented: $isShowingTimer) {
                        TimerView(meditationSession: meditationSession)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        if (meditationSession.minutesLeft > 0) || (meditationSession.secondsLeft > 0) {
                            meditationSession.isRunningTimer = true
                            isShowingTimer = true
                        }
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                    .fontWeight(.medium)
                    .saturation(0.75)
                }
                ToolbarItem {
                    Text("Duration")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.semibold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if (meditationSession.minutesLeft > 0) || (meditationSession.secondsLeft > 0) {
                            meditationSession.isRunningTimer = true
                            isShowingTimer = true
                        }
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                    .fontWeight(.medium)
                    .saturation(0.75)
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
