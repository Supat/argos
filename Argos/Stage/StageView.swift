//
//  StageView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StageView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    @State private var showingReportSheet: Bool = false
    @State private var timeRemaining: Int = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .topLeading) {
                HStack {
                    VStack {
                        VisionActivityTrackView();
                    }
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    VStack {
                        DemonstrationView(viewRouter: viewRouter);
                    }
                        .frame(minWidth: 0, maxWidth: .infinity);
                }
                VStack {
                    Spacer()
                        .frame(height: 25)
                    Button(action: {
                        self.viewRouter.currentPage = "selectionPage";
                    }) {
                        Text("Back");
                    }
                        .padding(.leading);
                }
            }
            
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(.black)
                                .opacity(0.75)
                        )
                    Spacer()
                        .frame(height: 25)
                }
            }
//            VStack {
//                ExternalSignalView();
//            }
//                .frame(maxHeight: 240)
//                .frame(maxWidth: .infinity)
//                .background(Color.gray);
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .onAppear() {
            print("Stage View appeared.")
        }
        
        .onReceive(timer) { time in
            if (self.timeRemaining > 0) {
                self.timeRemaining -= 1
                
                if (self.timeRemaining == 0) {
                    self.showingReportSheet.toggle()
                }
            }
        }
        
        .sheet(isPresented: $showingReportSheet, onDismiss: didDismissReportSheet) {
            ReportView(showingReportSheet: self.$showingReportSheet)
        }
    }
    
    private func didDismissReportSheet() {
        print("Report sheet dismissed.")
        self.viewRouter.currentPage = "selectionPage";
    }
}


struct StageView_Previews: PreviewProvider {
    static var previews: some View {
        StageView(viewRouter: ViewRouter())
    }
}
