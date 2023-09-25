//
//  MeditationSession.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/25/23.
//

import Foundation

class MeditationSession: ObservableObject {
    @Published var minutesLeft: Int
    @Published var secondsLeft: Int
    @Published var isRunningTimer: Bool
    @Published var isPresented: Bool
    
    init(minutesLeft: Int, secondsLeft: Int, isRunningTimer: Bool, isPresented: Bool) {
        self.minutesLeft = minutesLeft
        self.secondsLeft = secondsLeft
        self.isRunningTimer = isRunningTimer
        self.isPresented = isPresented
    }
}
