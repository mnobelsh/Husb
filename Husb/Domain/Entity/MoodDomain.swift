//
//  MoodDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import Foundation

struct MoodDomain {
    
    enum MoodType: String {
        case sad = "SAD"
        case angry = "ANGRY"
        case worried = "WORRIED"
        case tired = "TIRED"
        case excited = "EXCITED"
        case happy = "HAPPY"
    }
    
    var id: String = UUID().uuidString
    var type: MoodType
    var title: String
    var description: String
    
    init(type: MoodType) {
        self.type = type
        switch type {
        case .angry:
            self.title = "Angry"
            self.description = "Your wife is feeling angry today."
        case .excited:
            self.title = "Excited"
            self.description = "Your wife is feeling excited about today."
        case .happy:
            self.title = "Happy"
            self.description = "Your wife is feeling happy today."
        case .sad:
            self.title = "Sad"
            self.description = "Your wife is feeling sad today."
        case .tired:
            self.title = "Tired"
            self.description = "Your wife is feeling so tired of today."
        case .worried:
            self.title = "Worried"
            self.description = "Your wife is feeling worried about today."
        default:
            self.title = ""
            self.description = ""
        }
    }
    
}
