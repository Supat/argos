//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI
import RealityFoundation

struct StartActionView: View {
    
    @ObservedObject var viewRouter: ViewRouter;
    
    let video: Video;
    let category: Category;
    var body: some View {
        ZStack {
            VStack {
                Text(generateTitleText(for: category.name ?? "Unknown", at: video.difficulty))
                    .font(.headline);
                
                Spacer()
                    .frame(height: 50);
                
                //Text("\(String(describing: video.explanation))");
                
                Spacer()
                    .frame(height: 25);
                
                Text("Are you ready to start?");
                Button(action: {
                    print(video.name ?? "URL not found.");
                    self.viewRouter.videoURL = Bundle.main.url(forResource: video.name, withExtension: video.ext);
                    self.viewRouter.stageTimeLimit = 60;
                    self.viewRouter.stageName = video.label
                    self.viewRouter.stageLevel = video.difficulty
                    self.viewRouter.currentPage = "countdownPage";
                }) {
                    Text("Start");
                }
                Spacer()
                    .frame(height: 50)
                ScrollView(.vertical) {
                    VStack {
                        Group {
                            Image("TS01")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Group {
                                Text(DescriptionText.title1)
                                    .font(.title)
                                Text(DescriptionText.text1)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title2)
                                    .font(.title)
                                Text(DescriptionText.text2a)
                                    .font(.body)
                                Text(DescriptionText.text2b)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title3)
                                    .font(.title)
                                Text(DescriptionText.text3)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                            }
                            
                            Group {
                                Text(DescriptionText.title4)
                                    .font(.title)
                                Text(DescriptionText.text4a)
                                    .font(.body)
                                Text(DescriptionText.text4b)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title5)
                                    .font(.title)
                                Text(DescriptionText.text5)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title6)
                                    .font(.title)
                                Text(DescriptionText.text6)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                            }
                            
                            Group {
                                Text(DescriptionText.title7)
                                    .font(.title)
                                Text(DescriptionText.text7a)
                                    .font(.body)
                                Text(DescriptionText.text7b)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title8)
                                    .font(.title)
                                Text(DescriptionText.text8)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title9)
                                    .font(.title)
                                Text(DescriptionText.text9)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                            }
                            
                            Group {
                                Text(DescriptionText.title10)
                                    .font(.title)
                                Text(DescriptionText.text10)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title11)
                                    .font(.title)
                                Text(DescriptionText.text11a)
                                    .font(.body)
                                Text(DescriptionText.text11b)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Image("TS02")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                
                                Group {
                                    Text(DescriptionText.title12)
                                        .font(.title)
                                    Text(DescriptionText.text12)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                }
                            }
                            
                            Group {
                                Text(DescriptionText.title13)
                                    .font(.title)
                                Text(DescriptionText.text13a)
                                    .font(.body)
                                Text(DescriptionText.text13b)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Text(DescriptionText.title14)
                                    .font(.title)
                                Text(DescriptionText.text14)
                                    .font(.body)
                                Spacer()
                                    .frame(height: 20)
                                
                                Group {
                                    Text(DescriptionText.title15)
                                        .font(.title)
                                    Text(DescriptionText.text15a)
                                        .font(.body)
                                    Text(DescriptionText.text15b)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                }
                            }
                            
                            Group {
                                Group {
                                    Text(DescriptionText.title16)
                                        .font(.title)
                                    Text(DescriptionText.text16)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title17)
                                        .font(.title)
                                    Text(DescriptionText.text17)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title18)
                                        .font(.title)
                                    Text(DescriptionText.text18a)
                                        .font(.body)
                                    Text(DescriptionText.text18b)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                }
                                
                                Group {
                                    Text(DescriptionText.title19)
                                        .font(.title)
                                    Text(DescriptionText.text19)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title20)
                                        .font(.title)
                                    Text(DescriptionText.text20)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Image("TS03")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    Group {
                                        Text(DescriptionText.title21)
                                            .font(.title)
                                        Text(DescriptionText.text21a)
                                            .font(.body)
                                        Text(DescriptionText.text21b)
                                            .font(.body)
                                        Spacer()
                                            .frame(height: 20)
                                    }
                                }
                                
                                Group {
                                    Text(DescriptionText.title22)
                                        .font(.title)
                                    Text(DescriptionText.text22)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title23)
                                        .font(.title)
                                    Text(DescriptionText.text23)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title24)
                                        .font(.title)
                                    Text(DescriptionText.text24)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                }
                                
                                Group {
                                    Text(DescriptionText.title25)
                                        .font(.title)
                                    Text(DescriptionText.text25)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title26)
                                        .font(.title)
                                    Text(DescriptionText.text26)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title27)
                                        .font(.title)
                                    Text(DescriptionText.text27)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                }
                                
                                Group {
                                    Text(DescriptionText.title28)
                                        .font(.title)
                                    Text(DescriptionText.text28a)
                                        .font(.body)
                                    Text(DescriptionText.text28b)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                    Text(DescriptionText.title29)
                                        .font(.title)
                                    Text(DescriptionText.text29a)
                                        .font(.body)
                                    Text(DescriptionText.text29b)
                                        .font(.body)
                                    Spacer()
                                        .frame(height: 20)
                                    
                                }
                            }
                        }
                        
                    }
                    .padding(.horizontal, 50)
                }
            }
        }
    }
    
    private func generateTitleText(for stance: String, at level: Int16) -> String {
        return stance + " at Difficulty Level: " + String(level);
    }
}

struct DescriptionText {
    static let title1: String = "1. Migi yoko-fumikomi"
    static let text1: String = "Turn the head to the right, slowly cross the left foot in front of the right foot, heel raised (Kosa-dachi position), arms still stretched in front of you, open hands."
    
    static let title2: String = "2. Migi yoko-chudan-haishu-uke"
    static let text2a: String = "(2a) Put the left heel on the ground, then raise your right knee very high and hit a crushing kick (fumikomi) right to get into position kiba-dachi."
    static let text2b: String = "(2b) Simultaneously, arm the right hand against the left hip and block the right hand open (haishu-uke) middle level on the right."
    
    static let title3: String = "3. Hidari chudan mae-empi-uchi"
    static let text3: String = "On the spot, still in kiba-dachi, hit a left elbow (empi-uchi) in the open right hand. The hips remain in front."
    
    static let title4: String = "4. Hidari gedan-barai"
    static let text4a: String = "(4a) Orient the head to the left by bringing the 2 fists in hikite (vertical left fist on the right fist) to the right hip."
    static let text4b: String = "(4b) On your place, always in kiba-dachi, make a low left block of the left arm (gedan-barai), right fist in hikite."
    
    static let title5: String = "5. Migi chudan kagi-zuki"
    static let text5: String = "On the spot, always in kiba-dachi, make a punch right hook (kagi-zuki) average level. Bring the left fist back into hikeness."
    
    static let title6: String = "6. Hidari yoko-fumikomi"
    static let text6: String = "Cross slowly right foot over left foot, heel lifted."
    
    static let title7: String = "7. Migi chudan uchi-ude-uke"
    static let text7a: String = "(7a) Put the right heel to the ground and then lift high the left knee and hit a crushing kick (fumikomi) left to get in position kiba-dachi."
    static let text7b: String = "(7b) Simultaneously, arm the right fist against the left hip and block the right fist from the inside out (uchi-ude-uke) middle level on the right. The hips and the look are from the front."
    
    static let title8: String = "8. Migi gedan-barai"
    static let text8: String = "On the spot, always in kiba-dachi, perform simultaneously a low parry right (gedan-barai ) and a swept defense high left (nagashi-uke). The hips remain in front."
    
    static let title9: String = "9. Hidari jodan nagashi-uke"
    static let text9: String = "Immediately chained with a direct left-hand high-level punch (ura-zuki)."
    
    static let title10: String = "10. Hidari jodan ura-zuki"
    static let text10: String = "Left elbow resting on the back of the right fist."
    
    static let title11: String = "11. Hidari nami-gaeshi"
    static let text11a: String = "(11a) Turn the head to the left."
    static let text11b: String = "(11b) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi."
    
    static let title12: String = "12. Hidari chudan morote-tate-uke"
    static let text12: String = "Then realize on the spot a blocking reinforced left middle level (morote-tate-uke), right fist always under the left elbow."
    
    static let title13: String = "13. Migi nami-gaeshi"
    static let text13a: String = "(13a) Orient the head to the right."
    static let text13b: String = "(13b) Kick upward sweeping from the right foot (nami-gaeshi) to rest in kiba-dachi."
    
    static let title14: String = "14. Hidari chudan morote-soto-uke"
    static let text14: String = "Then make a blockage on the spot right from outside to inside medium level (morote-soto-uke), right fist always under the left elbow."
    
    static let title15: String = "15. Hidari chudan morote-yoko-zuki"
    static let text15a: String = "(15a) Orient the head to the left, bring the 2 fists in hikit, left vertical fist on the right fist, at the right hip."
    static let text15b: String = "(15b) Before performing on the spot, always in kiba-dachi, a double medium-level fist attack, stretched left arm (yoko-zuki) and folded right arm (kagi-zuki)."
    
    static let title16: String = "16. Hidari yoko-chudan-haishu-uke"
    static let text16: String = "Arm slowly and power the left hand under the right armpit and block with the left hand open (haishu-uke) middle level on the left. Right fist in hikite."
    
    static let title17: String = "17. Migi chudan mae-empi-uchi"
    static let text17: String = "On the spot, always in kiba-dachi, hit a right elbow (empi-uchi) in the open left hand. The hips remain in front."
    
    static let title18: String = "18. Migi gedan-barai"
    static let text18a: String = "(18a) Orient the head to the right, bring the 2 fists in hikité (vertical right fist on the left fist) to the left hip."
    static let text18b: String = "(18b) On the spot, always in kiba-dachi, make a right lower arm lock right (gedan-barai), left fist in hikeness."
    
    static let title19: String = "19. Hidari chudan kagi-zuki"
    static let text19: String = "On the spot, always in kiba-dachi, make a left punch in hook (kagi-zuki) average level. Bring back the right fist in hikeness."
    
    static let title20: String = "20. Migi yoko-fumikomi"
    static let text20: String = "Slowly cross the left foot in front of the right foot, heel raised."
    
    static let title21: String = "21. Hidari chudan uchi-ude-uke"
    static let text21a: String = "(21a) Put the left heel on the ground and then lift your right knee high and hit a crushing kick (fumikomi) right to get into the kiba-dachi position."
    static let text21b: String = "(21b) Simultaneously, arm the left fist against the right hip and block the left fist from the inside out (uchi-ude-uke) middle level on the left. The hips and the look are from the front."
    
    static let title22: String = "22. Hidari gedan-barai"
    static let text22: String = "On the spot, still in kiba-dachi, perform simultaneously a low left parade (gedan-barai) and a high right swept defense (nagashi-uke). The hips remain in front."
    
    static let title23: String = "23. Migi jodan nagashi-uke"
    static let text23: String = "Immediately chase with a straight right high-level punch (ura-zuki)."
    
    static let title24: String = "24. Migi jodan ura-zuki"
    static let text24: String = "Right elbow resting on the back of the left fist."
    
    static let title25: String = "25. Migi nami-gaeshi"
    static let text25: String = "Turn the head to the right."
    
    static let title26: String = "26. Migi chudan morote-tate-uke"
    static let text26: String = "Kick up and sweep up the right foot (nami-gaeshi) to rest in kiba-dachi. Then place a reinforced block right middle level (morote-tate-uke), left fist always under the right elbow."
    
    static let title27: String = "27. Hidari nami-gaeshi"
    static let text27: String = "Turn the head to the left."
    
    static let title28: String = "28. Migi chudan morote-soto-uke"
    static let text28a: String = "(28a) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi."
    static let text28b: String = "(28b) Then perform on the spot a blocking left from the outside to the inside middle level (morote-soto-uke), left fist always under the right elbow."
    
    static let title29: String = "29. Migi chudan morote-yoko-zuki"
    static let text29a: String = "(29a) Orient the head to the right, bring the 2 fists in hikite, right fist vertical on the left fist, to the left hip."
    static let text29b: String = "(29b) Then perform on the spot, always in kiba-dachi, a double attack middle-level fist, right arm extended (yoko-zuki) and left arm folded (kagi-zuki)."
}

//struct StartActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartActionView(viewRouter: ViewRouter())
//    }
//}
