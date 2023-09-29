//
//  TimerInputView.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/26/23.
//

import SwiftUI

struct TimerInputView: View {
    //
    // 🧘‍♂️ Creating Meditation Session instance that carries into Timer View
    //
    @StateObject var meditationSession =
    MeditationSession(
        type: "meditation", hoursLeft: 0, minutesLeft: 0, secondsLeft: 10, isRunningTimer: false, isPresented: false
    )
    @State private var isShowingTimer = false
    
    
    // ⏰ String that shows countdown time for how long the meditation will be
    var timeString: String {
        let secondString = String(format: "%02d", meditationSession.secondsLeft)
        var minuteString = String(meditationSession.minutesLeft) + ":"
        var hourString = String(meditationSession.hoursLeft) + ":"
        
    // Checking for single or double digit, and removing hour string if no necessary
        if meditationSession.minutesLeft < 10 && meditationSession.hoursLeft > 0 { minuteString = "0" + minuteString }
        if meditationSession.hoursLeft < 10 { hourString = "0" + hourString }
        if meditationSession.hoursLeft == 0 { hourString = "" }
        
        return hourString + minuteString + secondString
        
    }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.insightTimerColors[0].ignoresSafeArea()
                VStack {
                    Spacer()
                    VStack(spacing: -22.5) {
                        
            //
            /// ⏳ **Duration** NavLink - Links to View to edit Meditation Length
            //
                        
                        NavigationLink(destination: DurationInputView(meditationSession: meditationSession).navigationBarBackButtonHidden(true)) {
                            HStack {
                                Text("Duration")
                                Spacer()
                                Text("Meditation \(timeString)")
                                Text(">")
                            }
                            .padding(15)
                            .foregroundColor(.gray)
                            .background(Color.insightTimerColors[1])
                            .cornerRadius(30)
                        }
                        .padding()
                        
            //
            /// 🛎️ **Starting Bell** *Empty* NavLink - Statically set to Tibetan Singing Bowl sound
            //
                        
                        Group {
                            HStack {
                                Text("Starting Bell")
                                Spacer()
                                Group {
                                    Text("Tibetan Singing Bowl")
                                    Text(">")
                                }
                                .opacity(0.5)
                                
                            }
                            .padding(15)
                            .foregroundColor(.gray)
                            .background(Color.insightTimerColors[1])
                            .cornerRadius(30)
                        }
                        .padding()
                        
            //
            /// 🔉**Ambient Sound** *Empty* NavLink - Not available in this demo currently
            //
                        
                        Group {
                            HStack {
                                Text("Ambient Sound")
                                Spacer()
                                Group {
                                    Text("None")
                                    Text(">")
                                }
                                .opacity(0.5)
                            }
                            .padding(15)
                            .foregroundColor(.gray)
                            .background(Color.insightTimerColors[1])
                            .cornerRadius(30)
                        }
                        .padding()
                        
            //
            /// ⌛️**Ending Sound** *Empty* NavLink - Statically set to Bell Ding sound
            //
                        
                        Group {
                            HStack {
                                Text("Ending Bell")
                                Spacer()
                                Group {
                                    Text("Bell Ding")
                                    Text(">")
                                }
                                .opacity(0.5)
                            }
                            .padding(15)
                            .foregroundColor(.gray)
                            .background(Color.insightTimerColors[1])
                            .cornerRadius(30)
                            .padding()
                        }
                    }
                    Spacer()
                    
            //
            /// 🎬 Start Button - Begins the meditation 🧘‍♂️
            //
                    
                    Button {
                        if (meditationSession.minutesLeft > 0) || (meditationSession.secondsLeft > 0) ||
                            (meditationSession.hoursLeft > 0)
                        {
                            meditationSession.isRunningTimer = true
                            isShowingTimer = true
                        }
                    } label: {
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
                    .padding(.bottom, 100)
                    .frame(width: 79, height: 82)
                    .sheet(isPresented: $isShowingTimer) {
                        TimerView(meditationSession: meditationSession)
                    }
                }
            }
            
            //
            /// 🛠️ Toolbar - Title and ability to exit timer input View
            //
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 12))
                    }
                }
                ToolbarItem {
                    Text("Timer")
                        .foregroundColor(.white)
                        .padding(.trailing, 150)
                        .textCase(.uppercase)
                        .fontWeight(Font.Weight.semibold)
                }
            }
            .toolbarBackground(.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


struct TimerInputView_Previews: PreviewProvider {
    static var previews: some View {
        TimerInputView()
    }
}
