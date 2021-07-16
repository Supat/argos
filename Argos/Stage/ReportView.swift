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
    
    init(showingReportSheet: Binding<Bool>) {
        self._showingReportSheet = showingReportSheet
    }
    
    var body: some View {
        Button(action: {
            self.showingReportSheet = false
        }) {
            HStack {
                Spacer()
                Text("Dismiss")
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
