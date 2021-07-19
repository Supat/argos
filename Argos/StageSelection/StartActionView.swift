//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StartActionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea()
           
            ScrollView{
                
            Spacer()
                .frame(height: 100);
            
            VStack {
                Text("<Action Type at Difficulty Level>")
                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 40)))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer()
                    .frame(height: 50);
                
                //Text("Detail instruction for this session appears here");
                Text("<Follow and Practice!>")
                    .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 24)))
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 50)
                
                TekkiShodanView()
                    //.offset(y: -150)
                    //.padding(.bottom, -100)
                
                //Text("Are you ready to start?")
                //    .foregroundColor(.black)
                
                //Spacer()
                //    .frame(height: 40)
                
                Group{
                    
                    VStack{
                        
                            Text("<1. Migi yoko-fumikomi>")
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                            Text("<Turn the head to the right, slowly cross the left foot in front of the right foot, heel raised (Kosa-dachi position), arms still stretched in front of you, open hands.>")
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                                .foregroundColor(.gray)
                                .frame(width: 600, height: 100, alignment: .leading)
                            
                            Spacer()
                                .frame(height: 50)
                            
                            Text("<2. Migi yoko-chudan-haishu-uke>")
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                            Text("<(2a) Put the left heel on the ground, then raise your right knee very high and hit a crushing kick (fumikomi) right to get into position kiba-dachi.>")
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                                .foregroundColor(.gray)
                                .frame(width: 600, height: 100, alignment: .leading)
                            Text("<(2b) Arm the right hand against the left hip and block the right hand open (haishu-uke) middle level on the right.>")
                                .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                                .foregroundColor(.gray)
                                .frame(width: 600, height: 100, alignment: .leading)
                            
                        }
                        
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<3. Hidari chudan mae-empi-uchi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, still in kiba-dachi, hit a left elbow (empi-uchi) in the open right hand. The hips remain in front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<4. Hidari gedan-barai>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(4a) Orient the head to the left by bringing the 2 fists in hikite (vertical left fist on the right fist) to the right hip.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Text("<(4b) On your place, always in kiba-dachi, make a low left block of the left arm (gedan-barai), right fist in hikite.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                    }
                        
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<5. Migi chudan kagi-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, always in kiba-dachi, make a punch right hook (kagi-zuki) average level. Bring the left fist back into hikeness.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<6. Hidari yoko-fumikomi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Cross slowly right foot over left foot, heel lifted.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                    }
                    
                    Spacer()
                        .frame(height: 50)
                        
                    VStack{
                        Text("<7. Migi chudan uchi-ude-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(7a) Put the right heel to the ground and then lift high the left knee and hit a crushing kick (fumikomi) left to get in position kiba-dachi.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(7b) Simultaneously, arm the right fist against the left hip and block the right fist from the inside out (uchi-ude-uke) middle level on the right. The hips and the look are from the front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<8. Migi gedan-barai>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, always in kiba-dachi, perform simultaneously a low parry right (gedan-barai ) and a swept defense high left (nagashi-uke). The hips remain in front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<9. Hidari jodan nagashi-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Immediately chained with a direct left-hand high-level punch (ura-zuki).>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                        Text("<10. Hidari jodan ura-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Left elbow resting on the back of the right fist.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                    }
                    
                    VStack{
                        Text("<11. Hidari nami-gaeshi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(11a) Turn the head to the left>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        

                    }
                    
                }
                
                    //.frame(height: 50)
                
                TekkiShodanView2()
                
                
                Group{
                    VStack{
                        Text("<(11b) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<12. Hidari chudan morote-tate-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(width: 600, height: 100, alignment: .center)
                        Spacer()
                        
                        Text("<Then realize on the spot a blocking reinforced left middle level (morote-tate-uke), right fist always under the left elbow.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                    }
                    
                    VStack{
                        Text("<13. Migi nami-gaeshi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(13a) Orient the head to the right.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(13b) Kick upward sweeping from the right foot (nami-gaeshi) to rest in kiba-dachi.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<14. Hidari chudan morote-soto-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Then make a blockage on the spot right from outside to inside medium level (morote-soto-uke), right fist always under the left elbow.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<15. Hidari chudan morote-yoko-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(15a) Orient the head to the left, bring the 2 fists in hikit, left vertical fist on the right fist, at the right hip.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(15b) Before performing on the spot, always in kiba-dachi, a double medium-level fist attack, stretched left arm (yoko-zuki) and folded right arm (kagi-zuki).>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<16. Hidari yoko-chudan-haishu-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Arm slowly and power the left hand under the right armpit and block with the left hand open (haishu-uke) middle level on the left. Right fist in hikite.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<17. Migi chudan mae-empi-uchi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, always in kiba-dachi, hit a right elbow (empi-uchi) in the open left hand. The hips remain in front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<18. Migi gedan-barai>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(18a) Orient the head to the right, bring the 2 fists in hikité (vertical right fist on the left fist) to the left hip.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(18b) On the spot, always in kiba-dachi, make a right lower arm lock right (gedan-barai), left fist in hikeness.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<19. Hidari chudan kagi-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, always in kiba-dachi, make a left punch in hook (kagi-zuki) average level. Bring back the right fist in hikeness.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<20. Migi yoko-fumikomi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Slowly cross the left foot in front of the right foot, heel raised.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        
                    }
                    
                    VStack{
                        Text("<21. Hidari chudan uchi-ude-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(21a) Put the left heel on the ground and then lift your right knee high and hit a crushing kick (fumikomi) right to get into the kiba-dachi position.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                    }
                    
                }
                
                TekkiShodanView3()
                
                Group{
                    VStack{
                        Text("<(21b) Simultaneously, arm the left fist against the right hip and block the left fist from the inside out (uchi-ude-uke) middle level on the left. The hips and the look are from the front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                        Text("<22. Hidari gedan-barai>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<On the spot, still in kiba-dachi, perform simultaneously a low left parade (gedan-barai) and a high right swept defense (nagashi-uke). The hips remain in front.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<23. Migi jodan nagashi-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Immediately chase with a straight right high-level punch (ura-zuki).>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<24. Migi jodan ura-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Right elbow resting on the back of the left fist.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<25. Migi nami-gaeshi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Turn the head to the right.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                    }
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack{
                        Text("<26. Migi chudan morote-tate-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Kick up and sweep up the right foot (nami-gaeshi) to rest in kiba-dachi.Then place a reinforced block right middle level (morote-tate-uke), left fist always under the right elbow.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<27. Hidari nami-gaeshi>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<Turn the head to the left.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Spacer()
                            .frame(height: 50)
                    }
                    
                    VStack{
                        Text("<28. Migi chudan morote-soto-uke>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(28a) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(28b) Then perform on the spot a blocking left from the outside to the inside middle level (morote-soto-uke), left fist always under the right elbow.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                        
                        Text("<29. Migi chudan morote-yoko-zuki>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                        Text("<(29a) Orient the head to the right, bring the 2 fists in hikite, right fist vertical on the left fist, to the left hip.>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        Text("<(29b) Then perform on the spot, always in kiba-dachi, a double attack middle-level fist, right arm extended (yoko-zuki) and left arm folded (kagi-zuki).>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 20)))
                            .foregroundColor(.gray)
                            .frame(width: 600, height: 100, alignment: .leading)
                        
                        Spacer()
                            .frame(height: 50)
                    }
                    
                    VStack{
                        Text("<30. Finish!>")
                            .font(Font.system(size: UIFontMetrics.default.scaledValue(for: 30)))
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                            .frame(height: 50)
                        
                    }
                }
                
                    
                }
                .offset(y: -100)
                .padding(.bottom, -100)
                
                Spacer()
                    .frame(height: 50)
                
                Button(action: {
                    print("Start button is pressed")
                    self.viewRouter.currentPage = "stagePage";
                }) {
                    Text("Start")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(Color.green, lineWidth: 5)
                        )
                    
                }
                .offset(y: -50)
                
                Spacer()
                    .frame(height: 50)
            }
        }
    }
}

struct StartActionView_Previews: PreviewProvider {
    static var previews: some View {
        StartActionView(viewRouter: ViewRouter())
    }
}
