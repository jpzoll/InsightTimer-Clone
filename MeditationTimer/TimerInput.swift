//
//  TimerInput.swift
//  playground-swiftui
//
//  Created by Joe Zoll on 9/23/23.
//

import SwiftUI

struct TimerInput: View {
    @State private var minutesLeft = 5
    @State private var secondsLeft = 0
    @State private var minutePercentage = 1.0
    @State private var isRunningTimer = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack(spacing: 10) {
                Text("Duration")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
                ProgressView(value: minutePercentage)
                    .frame(width: 300)
                Text(secondsLeft >= 10 ?
                     "\(minutesLeft):\(secondsLeft)" :
                        "\(minutesLeft):0\(secondsLeft)")
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .shadow(color: .black, radius: 30)
                .frame(width: 75, height: 50)
                .background(.orange)
                .cornerRadius(20)
                .onReceive(timer) { _ in
                    if isRunningTimer && (minutesLeft > 0) && (secondsLeft > 0) {
                        secondsLeft -= 1
                    } else if isRunningTimer && (minutesLeft > 0) {
                        minutesLeft -= 1
                        secondsLeft = 59
                    } else {
                        isRunningTimer = false
                    }
                    
                    // Update Progress Bar
                    let secondsRemaining = Double((minutesLeft * 60) + secondsLeft)
                    withAnimation {
                        minutePercentage = (secondsRemaining / (5 * 60))
                    }
                }
                HStack {
                    Button {
                        isRunningTimer = true
                    } label: {
                        Image(systemName: "play")
                    }
                    Button {
                        if isRunningTimer {
                            isRunningTimer = false
                        } else {
                            minutesLeft = 5
                            secondsLeft = 0
                        }
                    } label: {
                        Image(systemName: isRunningTimer ? "pause" : "circle.fill")
                    }
                    Button("Accelerate") {
                        if secondsLeft > 10 {
                            secondsLeft -= 10
                        }
                    }
                }
            }
            
        }
    }
}

struct TimerInput_Previews: PreviewProvider {
    static var previews: some View {
        TimerInput()
    }
}
