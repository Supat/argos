//
//  StageSelectionView.swift
//  Argos
//
//  Created by Supat Saetia on 6/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct InstructionView: View {
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
            
            GeometryReader { proxy in
                VStack {
                    Text("<Welcome to Argos>")
                        .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 64)))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        
                    Spacer().frame(height: proxy.size.height*0.05)
                    //Text("Instruction appears here")
                        //.font(.largeTitle);
                    
                    Text("<Start Karate with Argos!>")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Spacer().frame(height: proxy.size.height*0.20)
                    
                    
                    AppInstruction()
                        .offset(y: -190)
                        .padding(.bottom, -190)
            
                    
                    VStack(alignment:.center){
                        Text("<1. Select an Action>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("<From 'Select Action', select an action and a difficulty level.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 50)
                        
                        
                        Spacer().frame(height: proxy.size.height*0.05)
                        
                        Text("<2. Connect iPad with Monitor>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("<Connect iPad to an external monitor using a display cable.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 50)
                        
                        Spacer().frame(height: proxy.size.height*0.05)
                        
                        Text("<3. Adjust the Camera>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Text("<Face the iPad rear camera towards your position, click 'start' when you are ready.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 50)
                    }
                    
                }.frame(
                    maxWidth:.infinity,
                    maxHeight: .infinity
                )
                
            }
        }
    }
}

struct StageSelectionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    var body: some View {
        NavigationView {
            
            //NavigationLink(
            //    destination: StageSelectionView(viewRouter: viewRouter)
            //) {
            //    Text("Display Instruction")
            //}.navigationBarTitle("Back");
                
            
            List {
                ActionCategoryRow(viewRouter: viewRouter);
                ActionCategoryRow(viewRouter: viewRouter);
                ActionCategoryRow(viewRouter: viewRouter);
                ActionCategoryRow(viewRouter: viewRouter);
                ActionCategoryRow(viewRouter: viewRouter);
            }
            .navigationBarTitle("Select Action");
            
            InstructionView();
        }
    }
}


struct StageSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        StageSelectionView(viewRouter: ViewRouter())
    }
}
