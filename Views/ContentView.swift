//
//  ContentView.swift
//  MeditationTimer
//
//  Created by Joe Zoll on 9/24/23.
//

//
//  Playground.swift
//  playground-swiftui
//
//  Created by Joe Zoll on 9/23/23.
//

import SwiftUI

struct ContentView: View {
    
    //
    //
    /// ➡️ Welcome to the home page!  If you are reading this back, I would recommend
    ///    checking out  **TimerInputView** first, as that is what you are greeted with on startup.
    ///    This serves as a minimal version of Insight Timer's home screen, which may
    ///    be expanded upon in future version. For now, this allows you to restart the demo.
    //
    //
    
    let options = [
        Option(name: "Timer", image_str: "insightTimerIcon"),
    ]
    @State private var isShowing = false
    @State private var seconds = 0
    
    var body: some View {
        
        //
        /// 🧘‍♂️ **Meditation Timer Button** - Starts demo
        //
        
        ZStack {
            Color.insightTimerColors[2]
                .ignoresSafeArea()
            VStack {
                ForEach(options) { option in
                    Button {
                        isShowing = true
                    } label: {
                        ZStack {
                            Text("\(option.name)")
                                .fontWeight(.regular)
                                .font(.largeTitle)
                                .shadow(color: .black, radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 200)
                                .background(Color.insightTimerColors[3])
                                .cornerRadius(20)
                        }
                    }
                }
            }
        }
        /// Bring user directly to timer input on booting up
        .onAppear {
            isShowing = true
        }
        /// Timer input View in a sheet
        .sheet(isPresented: $isShowing) {
            TimerInputView()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
