//
//  CountDown.swift
//  Argos
//
//  Created by Jin Han on 2021/6/23.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct CountDown: View {
    @State var timeRemaining = 5
    @Binding var startSession : Bool
    @Binding var startCountDown: Bool
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        RoundedRectangle(cornerRadius: 0).overlay(
            Text(timeRemaining > 0 ? "\(timeRemaining)" : "Start!")
                .foregroundColor(Color.blue)
                .font(.largeTitle)
                .onReceive(timer) { _ in
                   if timeRemaining > 0 {
                       timeRemaining -= 1
                   }
                   else if timeRemaining == 0 {
                        startCountDown = false
                        timeRemaining = 5
                    }
               }
        )
        .frame(width: 200, height: 70, alignment: .center)
    }
}

