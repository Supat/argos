//
//  StartActionView.swift
//  Argos
//
//  Created by Supat Saetia on 7/7/20.
//  Copyright © 2020 Supat Saetia. All rights reserved.
//

import SwiftUI

struct StartActionView: View {
    @Environment(ViewRouter.self) private var router

    let video: Video
    let category: Category

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 20) {
                Text(titleText)
                    .font(.headline)

                Text("Are you ready to start?")

                Button("Start", action: startStage)
                    .buttonStyle(.borderedProminent)

                Image("TS01")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ForEach(KataDescription.steps) { step in
                    KataStepView(step: step)
                }

                Image("TS02")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ForEach(KataDescription.stepsContinued) { step in
                    KataStepView(step: step)
                }

                Image("TS03")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                ForEach(KataDescription.stepsFinal) { step in
                    KataStepView(step: step)
                }
            }
            .padding(.horizontal, 50)
            .padding(.vertical, 20)
        }
    }

    private var titleText: String {
        let name = category.name ?? "Unknown"
        return "\(name) at Difficulty Level: \(video.difficulty)"
    }

    private func startStage() {
        guard
            let resourceName = video.name,
            let ext = video.ext,
            let url = Bundle.main.url(forResource: resourceName, withExtension: ext),
            let label = video.label,
            let difficulty = StageDifficulty(rawValue: video.difficulty)
        else {
            assertionFailure("Cannot launch stage; missing video metadata.")
            return
        }

        router.startCountdown(with: StageContext(
            videoURL: url,
            stageName: label,
            difficulty: difficulty
        ))
    }
}

private struct KataStepView: View {
    let step: KataDescription.Step

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(step.title)
                .font(.title)
            ForEach(Array(step.body.enumerated()), id: \.offset) { _, line in
                Text(line)
                    .font(.body)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

/// Static, structured description of the Tekki-shodan kata, replacing the
/// previous flat namespace of dozens of `static let` strings.
enum KataDescription {
    struct Step: Identifiable {
        let id: Int
        let title: String
        let body: [String]
    }

    static let steps: [Step] = [
        Step(id: 1, title: "1. Migi yoko-fumikomi", body: [
            "Turn the head to the right, slowly cross the left foot in front of the right foot, heel raised (Kosa-dachi position), arms still stretched in front of you, open hands."
        ]),
        Step(id: 2, title: "2. Migi yoko-chudan-haishu-uke", body: [
            "(2a) Put the left heel on the ground, then raise your right knee very high and hit a crushing kick (fumikomi) right to get into position kiba-dachi.",
            "(2b) Simultaneously, arm the right hand against the left hip and block the right hand open (haishu-uke) middle level on the right."
        ]),
        Step(id: 3, title: "3. Hidari chudan mae-empi-uchi", body: [
            "On the spot, still in kiba-dachi, hit a left elbow (empi-uchi) in the open right hand. The hips remain in front."
        ]),
        Step(id: 4, title: "4. Hidari gedan-barai", body: [
            "(4a) Orient the head to the left by bringing the 2 fists in hikite (vertical left fist on the right fist) to the right hip.",
            "(4b) On your place, always in kiba-dachi, make a low left block of the left arm (gedan-barai), right fist in hikite."
        ]),
        Step(id: 5, title: "5. Migi chudan kagi-zuki", body: [
            "On the spot, always in kiba-dachi, make a punch right hook (kagi-zuki) average level. Bring the left fist back into hikeness."
        ]),
        Step(id: 6, title: "6. Hidari yoko-fumikomi", body: [
            "Cross slowly right foot over left foot, heel lifted."
        ]),
        Step(id: 7, title: "7. Migi chudan uchi-ude-uke", body: [
            "(7a) Put the right heel to the ground and then lift high the left knee and hit a crushing kick (fumikomi) left to get in position kiba-dachi.",
            "(7b) Simultaneously, arm the right fist against the left hip and block the right fist from the inside out (uchi-ude-uke) middle level on the right. The hips and the look are from the front."
        ]),
        Step(id: 8, title: "8. Migi gedan-barai", body: [
            "On the spot, always in kiba-dachi, perform simultaneously a low parry right (gedan-barai ) and a swept defense high left (nagashi-uke). The hips remain in front."
        ]),
        Step(id: 9, title: "9. Hidari jodan nagashi-uke", body: [
            "Immediately chained with a direct left-hand high-level punch (ura-zuki)."
        ]),
        Step(id: 10, title: "10. Hidari jodan ura-zuki", body: [
            "Left elbow resting on the back of the right fist."
        ]),
        Step(id: 11, title: "11. Hidari nami-gaeshi", body: [
            "(11a) Turn the head to the left.",
            "(11b) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi."
        ]),
    ]

    static let stepsContinued: [Step] = [
        Step(id: 12, title: "12. Hidari chudan morote-tate-uke", body: [
            "Then realize on the spot a blocking reinforced left middle level (morote-tate-uke), right fist always under the left elbow."
        ]),
        Step(id: 13, title: "13. Migi nami-gaeshi", body: [
            "(13a) Orient the head to the right.",
            "(13b) Kick upward sweeping from the right foot (nami-gaeshi) to rest in kiba-dachi."
        ]),
        Step(id: 14, title: "14. Hidari chudan morote-soto-uke", body: [
            "Then make a blockage on the spot right from outside to inside medium level (morote-soto-uke), right fist always under the left elbow."
        ]),
        Step(id: 15, title: "15. Hidari chudan morote-yoko-zuki", body: [
            "(15a) Orient the head to the left, bring the 2 fists in hikit, left vertical fist on the right fist, at the right hip.",
            "(15b) Before performing on the spot, always in kiba-dachi, a double medium-level fist attack, stretched left arm (yoko-zuki) and folded right arm (kagi-zuki)."
        ]),
        Step(id: 16, title: "16. Hidari yoko-chudan-haishu-uke", body: [
            "Arm slowly and power the left hand under the right armpit and block with the left hand open (haishu-uke) middle level on the left. Right fist in hikite."
        ]),
        Step(id: 17, title: "17. Migi chudan mae-empi-uchi", body: [
            "On the spot, always in kiba-dachi, hit a right elbow (empi-uchi) in the open left hand. The hips remain in front."
        ]),
        Step(id: 18, title: "18. Migi gedan-barai", body: [
            "(18a) Orient the head to the right, bring the 2 fists in hikité (vertical right fist on the left fist) to the left hip.",
            "(18b) On the spot, always in kiba-dachi, make a right lower arm lock right (gedan-barai), left fist in hikeness."
        ]),
        Step(id: 19, title: "19. Hidari chudan kagi-zuki", body: [
            "On the spot, always in kiba-dachi, make a left punch in hook (kagi-zuki) average level. Bring back the right fist in hikeness."
        ]),
        Step(id: 20, title: "20. Migi yoko-fumikomi", body: [
            "Slowly cross the left foot in front of the right foot, heel raised."
        ]),
    ]

    static let stepsFinal: [Step] = [
        Step(id: 21, title: "21. Hidari chudan uchi-ude-uke", body: [
            "(21a) Put the left heel on the ground and then lift your right knee high and hit a crushing kick (fumikomi) right to get into the kiba-dachi position.",
            "(21b) Simultaneously, arm the left fist against the right hip and block the left fist from the inside out (uchi-ude-uke) middle level on the left. The hips and the look are from the front."
        ]),
        Step(id: 22, title: "22. Hidari gedan-barai", body: [
            "On the spot, still in kiba-dachi, perform simultaneously a low left parade (gedan-barai) and a high right swept defense (nagashi-uke). The hips remain in front."
        ]),
        Step(id: 23, title: "23. Migi jodan nagashi-uke", body: [
            "Immediately chase with a straight right high-level punch (ura-zuki)."
        ]),
        Step(id: 24, title: "24. Migi jodan ura-zuki", body: [
            "Right elbow resting on the back of the left fist."
        ]),
        Step(id: 25, title: "25. Migi nami-gaeshi", body: [
            "Turn the head to the right."
        ]),
        Step(id: 26, title: "26. Migi chudan morote-tate-uke", body: [
            "Kick up and sweep up the right foot (nami-gaeshi) to rest in kiba-dachi. Then place a reinforced block right middle level (morote-tate-uke), left fist always under the right elbow."
        ]),
        Step(id: 27, title: "27. Hidari nami-gaeshi", body: [
            "Turn the head to the left."
        ]),
        Step(id: 28, title: "28. Migi chudan morote-soto-uke", body: [
            "(28a) Make a kick sweep up the left foot (nami-gaeshi) to rest in kiba-dachi.",
            "(28b) Then perform on the spot a blocking left from the outside to the inside middle level (morote-soto-uke), left fist always under the right elbow."
        ]),
        Step(id: 29, title: "29. Migi chudan morote-yoko-zuki", body: [
            "(29a) Orient the head to the right, bring the 2 fists in hikite, right fist vertical on the left fist, to the left hip.",
            "(29b) Then perform on the spot, always in kiba-dachi, a double attack middle-level fist, right arm extended (yoko-zuki) and left arm folded (kagi-zuki)."
        ]),
    ]
}
