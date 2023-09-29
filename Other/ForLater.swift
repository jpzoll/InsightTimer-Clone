//
//  ForLater.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/25/23.
//

import Foundation
import SwiftUI

// Save Button - Starts the Meditation
struct SaveButton: View {
    var body: some View {
        Button {
//            if (meditationSession.minutesLeft > 0) || (meditationSession.secondsLeft > 0) {
//                meditationSession.isRunningTimer = true
//                isShowingTimer = true
//            }
        } label: {
            ZStack {
                Text("Start")
                    .opacity(0.8)
                    .textCase(.uppercase)
                    .foregroundColor(.black)
                    .background {
                        Ellipse()
                            .fill(.white)
                            .frame(width: 79, height: 82)
                    }
            }
        }}
}
