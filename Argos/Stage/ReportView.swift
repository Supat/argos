//
//  ReportView.swift
//  ReportView
//
//  Created by Supat Saetia on 2021/07/16.
//  Copyright © 2021 Supat Saetia. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    
    @Binding var showingReportSheet: Bool
    @Binding var performanceScore: Int
    
    init(showingReportSheet: Binding<Bool>, performanceScore: Binding<Int>) {
        self._showingReportSheet = showingReportSheet
        self._performanceScore = performanceScore
    }
    
    var body: some View {
        Button(action: {
            self.showingReportSheet = false
        }) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Score: " + self.performanceScore.description)
                    Spacer()
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Dismiss")
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

//struct ReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportView()
//    }
//}
