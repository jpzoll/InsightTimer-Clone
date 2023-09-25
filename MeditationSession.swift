//
//  MeditationSession.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/25/23.
//

import Foundation

class MeditationSession: ObservableObject {
    @Published var hoursLeft: Int
    @Published var minutesLeft: Int
    @Published var secondsLeft: Int
    @Published var isRunningTimer: Bool
    @Published var isPresented: Bool
    
    init(hoursLeft: Int, minutesLeft: Int, secondsLeft: Int, isRunningTimer: Bool, isPresented: Bool) {
        self.hoursLeft = hoursLeft
        self.minutesLeft = minutesLeft
        self.secondsLeft = secondsLeft
        self.isRunningTimer = isRunningTimer
        self.isPresented = isPresented
    }
    
    func reset() {
        self.hoursLeft = 0
        self.minutesLeft = 0
        self.secondsLeft = 10
        self.isRunningTimer = false
        self.isPresented = false
    }
}
