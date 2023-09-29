//
//  DurationInputView.swift
//  playground-swiftui
//
//  Created by Joe Zoll on 9/23/23.
//

import SwiftUI

struct DurationInputView: View {
    //
    // ➡️ 🧘‍♂️ Carrying Meditation Session into Timer View
    //
    @ObservedObject var meditationSession: MeditationSession
    @State private var initialSession: MeditationSession
    init(meditationSession: MeditationSession) {
        /// Saving both before and 'after' states
        self.meditationSession = meditationSession
        self._initialSession = State(initialValue: meditationSession.copy())
        /// Warmup timer styling
        setupUIKitStyling()
    }
    
    // 👇 Picking type of meditation options
    let sessionTypes = [
        "Meditation",
        "Yoga",
        "Tai Chi",
        "Walking",
        "Breathing",
        "Chanting",
        "Prayer",
        "Healing"
    ]
    // 🕛 Second values for time *and* warmup picker
    let secondValues = [0, 10, 20, 30, 40, 50]
    
    /// Hides view upon **Cancel** or **Save**
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.insightTimerColors[0]
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    
            //
            /// ⏰ **Time Picker** - Choose hours, minutes, and seconds for meditation
            //
            
                    
                /// Hours
                    HStack(spacing: -20) {
                        HStack {
                            Picker("Hours", selection: $meditationSession.hoursLeft) {
                                ForEach(0..<24, id: \.self) { hour in
                                    Text(String(format: "%02d", hour))
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 55)
                            
                            Text("h")
                                .padding(.leading, -12)
                                .foregroundColor(.white)
                        }
                        .padding()
                /// Minutes
                        HStack {
                            Picker("Minutes", selection: $meditationSession.minutesLeft) {
                                ForEach(0..<60, id: \.self) { minute in
                                    Text(String(format: "%02d", minute))
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 55)
                            
                            Text("m")
                                .padding(.leading, -12)
                                .foregroundColor(.white)
                        }
                        .padding()
                /// Seconds
                        HStack {
                            Picker("Seconds", selection: $meditationSession.secondsLeft) {
                                ForEach(secondValues, id: \.self) { second in
                                    Text(String(format: "%02d", second))
                                        .foregroundColor(.white)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(width: 55)
                            
                            Text("s")
                                .padding(.leading, -12)
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                    //.border(.purple)
                    Spacer()
                    Spacer()
                    
            //
            /// 📿 **Type Picker** - Choose the type of meditation (yoga, prayer, regular meditation, etc.)
            //
                    
                    
                    VStack {
                        Menu {
                            Picker("Session Type", selection: $meditationSession.type) {
                                ForEach(sessionTypes, id: \.self) { type in
                                    withAnimation(.none) {
                                        Text(type)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text("\(meditationSession.type.capitalized)")
                                Text("⌵")
                                    .offset(y: -6)
                                    .frame(width: 15, height: 12)
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.light)
                        }
                        // Picker does an unwanted animation without this
                        // FIX: DEPRECATION WARNING
                        .animation(nil)
                    }
                    .frame(width: 250)
                    //.border(.yellow)
                    
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    
            //
            /// 🙆 **Warm up Picker** - Choose the amount of seconds you'd like to warmup before starting
            //
                    
                    
                    VStack(spacing: 10) {
                        Text("Warm Up")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.light)
                        Picker("Warm up", selection: $meditationSession.warmupSeconds) {
                            ForEach(secondValues, id: \.self) { second in
                                Text("\(second)s")
                                    .foregroundColor(.white)
                            }
                        }
                        .pickerStyle(.segmented)
                        .background(Color.insightTimerColors[0])
                        .tint(.red)
                    }
                    .frame(width: 385)
                    //.border(.red)
                    
                }
            }
            
        //
        /// 🛠️ **Toolbar** - Title and ability to 1) *Cancel* or 2) *Save* duration input
        //
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        meditationSession.hoursLeft = initialSession.hoursLeft
                        meditationSession.minutesLeft = initialSession.minutesLeft
                        meditationSession.secondsLeft = initialSession.secondsLeft
                        dismiss()
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                    .fontWeight(.medium)
                    .saturation(0.75)
                }
                ToolbarItem {
                    Text("Duration")
                        .foregroundColor(.white)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .padding(.trailing, 95)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        if (meditationSession.minutesLeft > 0) || (meditationSession.secondsLeft > 0) ||
                            (meditationSession.hoursLeft > 0){
                            dismiss()
                        }
                    }
                    .foregroundColor(.red)
                    .font(.caption)
                    .fontWeight(.medium)
                    .saturation(0.75)
                }
            }
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    private func setupUIKitStyling() {
        /// Warmup timer styling
        UISegmentedControl.appearance().selectedSegmentTintColor = Color.uiColor(.insightTimerColors[0])()
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14.0, weight: .thin)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .normal)
    }
}

struct DurationInputView_Previews: PreviewProvider {
    static var previews: some View {
        DurationInputView(meditationSession: MeditationSession(type: "meditation", hoursLeft: 0, minutesLeft: 25, secondsLeft: 0, isRunningTimer: false, isPresented: false))
    }
}
