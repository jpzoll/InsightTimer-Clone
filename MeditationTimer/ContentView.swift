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

struct Option: Identifiable {
    var id = UUID()
    let name: String
    let image_str: String
    var isShowing = false
}

struct ContentView: View {
    let options = [
        Option(name: "Meditation", image_str: "meditation"),
        Option(name: "Sleep", image_str: "sleep"),
        Option(name: "Parenting", image_str: "blocks"),
    ]
    @State private var isShowing = false
    @State private var seconds = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            VStack {
                ForEach(options) { option in
                    Button {
                        if option.name == "Meditation" {
                            isShowing = true
                        }
                    } label: {
                        ZStack {
                            Text("\(option.name)")
                                .italic()
                                .bold()
                                .font(.largeTitle)
                                .shadow(color: .black, radius: 10)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 200)
                                .background {
                                    Image("\(option.image_str)")
                                        .blur(radius: 2)
                                }
                                .cornerRadius(20)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isShowing) {
            TimerInput()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
