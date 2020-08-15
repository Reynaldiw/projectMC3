//
//  AdditionalSoundModel.swift
//  ProjectPodcastMC3
//
//  Created by Reynaldi Wijaya on 13/08/20.
//  Copyright © 2020 Reynaldi Wijaya. All rights reserved.
//

import Foundation
import AVFoundation

struct AdditionalSoundModel {
    var nameOfSounds: String?
    var url: URL?
    var duration: Int?
    
    static func getModel() -> [AdditionalSoundModel] {
        let nameOfSounds = "Aggressive Motorcycle"
        let nameOfSounds2 = "Alarm Clock"
        let nameOfSounds3 = "Apa yang baru"
        let nameOfSounds4 = "Baseball Glove Handling"
        let nameOfSounds5 = "Beep Short"
        let nameOfSounds6 = "Broken plates"
        let nameOfSounds7 = "Car Door Closing"
        let nameOfSounds8 = "Car Door Open Shut"
        let nameOfSounds9 = "Car Door"
        let nameOfSounds10 = "Cartoon Boing"
        let nameOfSounds11 = "Cartoon Cowbell"
        let nameOfSounds12 = "Cat Purr"
        let nameOfSounds13 = "Concussive Guitar Hit"
        let nameOfSounds14 = "Concussive Hit Guitar Boing"
        let nameOfSounds15 = "Dream Breath"
        let nameOfSounds16 = "Drinking from Water Fountain"
        let nameOfSounds17 = "Emergency Siren Distant"
        let nameOfSounds18 = "Enjoy podcast on Instagram"
        let nameOfSounds19 = "Female Crowd Celebration"
        let nameOfSounds20 = "Higlight Podcast"
        let nameOfSounds21 = "Kelanjutannya 1"
        let nameOfSounds22 = "Kelanjutannya"
        let nameOfSounds23 = "Meepo"
        let nameOfSounds24 = "Planet"
        let nameOfSounds25 = "Scissor_Snips"
        
        let nameOfFileSounds = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Aggressive_Motorcycle", ofType: "mp3")!)
        print(nameOfFileSounds)
        let nameOfFileSounds2 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Alarm_Clock", ofType: "mp3")!)
        let nameOfFileSounds3 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "apa yang baru", ofType: "mp3")!)
        let nameOfFileSounds4 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Baseball_Glove_Handling", ofType: "mp3")!)
        let nameOfFileSounds5 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Beep_Short", ofType: "mp3")!)
        let nameOfFileSounds6 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Broken_plates", ofType: "mp3")!)
        let nameOfFileSounds7 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Car_Door_Closing", ofType: "mp3")!)
        let nameOfFileSounds8 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Car_Door_Open_Shut", ofType: "mp3")!)
        let nameOfFileSounds9 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Car_Door", ofType: "mp3")!)
        let nameOfFileSounds10 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Cartoon_Boing", ofType: "mp3")!)
        let nameOfFileSounds11 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Cartoon_Cowbell", ofType: "mp3")!)
        let nameOfFileSounds12 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Cat_Purr", ofType: "mp3")!)
        let nameOfFileSounds13 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Concussive_Guitar_Hit", ofType: "mp3")!)
        let nameOfFileSounds14 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Concussive_Hit_Guitar_Boing", ofType: "mp3")!)
        let nameOfFileSounds15 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Dream_Breath", ofType: "mp3")!)
        let nameOfFileSounds16 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Drinking_from_Water_Fountain", ofType: "mp3")!)
        let nameOfFileSounds17 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Emergency_Siren_Distant", ofType: "mp3")!)
        let nameOfFileSounds18 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "enjoy podcast on instagram", ofType: "mp3")!)
        let nameOfFileSounds19 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Female_Crowd_Celebration", ofType: "mp3")!)
        let nameOfFileSounds20 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "higlight podcast", ofType: "mp3")!)
        let nameOfFileSounds21 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "kelanjutannya 1", ofType: "mp3")!)
        let nameOfFileSounds22 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "kelanjutannya", ofType: "mp3")!)
        let nameOfFileSounds23 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "meepo", ofType: "mp3")!)
        let nameOfFileSounds24 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "planet", ofType: "mp3")!)
        let nameOfFileSounds25 = URL.init(fileURLWithPath: Bundle.main.path(forResource: "Scissor_Snips", ofType: "mp3")!)
        
        let duration = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds).duration))
        print(duration)
        let duration2 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds2).duration))
        let duration3 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds3).duration))
        let duration4 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds4).duration))
        let duration5 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds5).duration))
        let duration6 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds6).duration))
        let duration7 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds7).duration))
        let duration8 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds8).duration))
        let duration9 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds9).duration))
        let duration10 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds10).duration))
        let duration11 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds11).duration))
        let duration12 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds12).duration))
        let duration13 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds13).duration))
        let duration14 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds14).duration))
        let duration15 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds15).duration))
        let duration16 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds16).duration))
        let duration17 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds17).duration))
        let duration18 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds18).duration))
        let duration19 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds19).duration))
        let duration20 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds20).duration))
        let duration21 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds21).duration))
        let duration22 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds22).duration))
        let duration23 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds23).duration))
        let duration24 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds24).duration))
        let duration25 = Int(CMTimeGetSeconds(AVAsset(url: nameOfFileSounds25).duration))
        
        var resultModel = [AdditionalSoundModel]()
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds, url: nameOfFileSounds, duration: duration))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds2, url: nameOfFileSounds2, duration: duration2))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds3, url: nameOfFileSounds3, duration: duration3))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds4, url: nameOfFileSounds4, duration: duration4))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds5, url: nameOfFileSounds5, duration: duration5))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds6, url: nameOfFileSounds6, duration: duration6))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds7, url: nameOfFileSounds7, duration: duration7))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds8, url: nameOfFileSounds8, duration: duration8))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds9, url: nameOfFileSounds9, duration: duration9))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds10, url: nameOfFileSounds10, duration: duration10))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds11, url: nameOfFileSounds11, duration: duration11))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds12, url: nameOfFileSounds12, duration: duration12))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds13, url: nameOfFileSounds13, duration: duration13))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds14, url: nameOfFileSounds14, duration: duration14))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds15, url: nameOfFileSounds15, duration: duration15))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds16, url: nameOfFileSounds16, duration: duration16))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds17, url: nameOfFileSounds17, duration: duration17))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds18, url: nameOfFileSounds18, duration: duration18))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds19, url: nameOfFileSounds19, duration: duration19))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds20, url: nameOfFileSounds20, duration: duration20))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds21, url: nameOfFileSounds21, duration: duration21))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds22, url: nameOfFileSounds22, duration: duration22))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds23, url: nameOfFileSounds23, duration: duration23))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds24, url: nameOfFileSounds24, duration: duration24))
        resultModel.append(AdditionalSoundModel(nameOfSounds: nameOfSounds25, url: nameOfFileSounds25, duration: duration25))
        
        return resultModel
    }
}
