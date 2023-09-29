//
//  MeditationSession.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/25/23.
//

import Foundation

class MeditationSession: ObservableObject {
    //
    // 🧘‍♂️ Meditation Session Properties 📦
    //
    
    /// Description of the session type
    @Published var type: String
    
    /// Remaining time components
    @Published var hoursLeft: Int
    @Published var minutesLeft: Int
    @Published var secondsLeft: Int
    
    /// Warm-up duration in seconds
    @Published var warmupSeconds = 0
    
    /// Flags indicating whether the timer is running and if the view is presented
    @Published var isRunningTimer: Bool
    @Published var isPresented: Bool
    
    /// Meditation Timer instance
    @Published var timer = MeditationTimer(isRunning: false, hoursLeft: 0, minutesLeft: 0, secondsLeft: 0)
    
    //
    // ➡️ Initialization
    //
    
    init(type: String, hoursLeft: Int, minutesLeft: Int, secondsLeft: Int, isRunningTimer: Bool, isPresented: Bool) {
        self.type = type
        
        self.hoursLeft = hoursLeft
        self.minutesLeft = minutesLeft
        self.secondsLeft = secondsLeft
        self.warmupSeconds = 0
        
        self.isRunningTimer = isRunningTimer
        self.isPresented = isPresented
    }
    
    //
    // ➡️ Session Management Methods
    //
    
    /// Reset session to specified values
    func reset(hours: Int, minutes: Int, seconds: Int, warmupSeconds: Int) {
        self.hoursLeft = hours
        self.minutesLeft = minutes
        self.secondsLeft = seconds
        self.warmupSeconds = warmupSeconds
        self.isRunningTimer = false
        self.isPresented = false
    }
    
    /// Reset session to default values
    func resetToDefault() {
        self.hoursLeft = 0
        self.minutesLeft = 0
        self.secondsLeft = 10
        self.warmupSeconds = 0
        self.isRunningTimer = false
        self.isPresented = false
    }
    
    /// Create a copy of the session
    func copy() -> MeditationSession {
        let copiedSession = MeditationSession(type: self.type, hoursLeft: self.hoursLeft, minutesLeft: self.minutesLeft, secondsLeft: self.secondsLeft, isRunningTimer: self.isRunningTimer, isPresented: self.isPresented)
        // Copy other properties as needed
        return copiedSession
    }
    
    //
    // ➡️ Timer Logic
    //
    
    /// Update the remaining time and manage timer state
    func updateTime() {
        print("time: \(self.minutesLeft):\(self.secondsLeft)")
        if self.isRunningTimer {
            
            if self.warmupSeconds <= 0 {
                
                if self.secondsLeft > 0 {
                    /// Decrement seconds if there are more than 0 seconds left
                    self.secondsLeft -= 1
                } else if self.minutesLeft > 0 {
                    /// Decrement minutes and reset seconds to 59 when seconds reach 0
                    self.minutesLeft -= 1
                    self.secondsLeft = 59
                } else if self.hoursLeft > 0 {
                    /// Decrement hours, reset minutes and seconds to 59 when minutes reach 0
                    self.hoursLeft -= 1
                    self.minutesLeft = 59
                    self.secondsLeft = 59
                } else {
                    /// Timer and meditation are complete, **STOP** the timer!
                    self.isRunningTimer = false
                    ///
                    // END COUNTDOWN LOGIC
                    ///
                }
            } else {
                if self.warmupSeconds > 0 {
                    self.warmupSeconds -= 1
                }
            }
        }
    }
}
