//
//  CountdownView.swift
//  CountdownView
//
//  Created by Supat Saetia on 2021/07/16.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct CountdownView: View {
    @ObservedObject var viewRouter: ViewRouter
    
    @State var startTimeRemaining: Int = 6
    @State var readyText: String = "Ready..."
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Text(self.readyText)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(.black)
                        .opacity(0.75)
                    )
        }
        
        .onReceive(timer) { time in
            if (startTimeRemaining > 0) {
                self.startTimeRemaining -= 1
                
                switch self.startTimeRemaining {
                case 3:
                    self.readyText = "Set.."
                case 1:
                    self.readyText = "Go!"
                default:
                    break
                }
                
                if (self.startTimeRemaining == 0) {
                    self.viewRouter.currentPage = "stagePage";
                }
            }

        }
    }
}

//struct CountdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        CountdownView()
//    }
//}
