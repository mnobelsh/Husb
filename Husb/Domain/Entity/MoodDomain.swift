//
//  MoodDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

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
    var icon: UIImage
    
    init(type: MoodType) {
        self.type = type
        switch type {
        case .angry:
            self.title = "Angry"
            self.description = "Your wife is feeling angry today."
            self.icon = .moodAngry
        case .excited:
            self.title = "Excited"
            self.description = "Your wife is feeling excited about today."
            self.icon = .moodExcited
        case .happy:
            self.title = "Happy"
            self.description = "Your wife is feeling happy today."
            self.icon = .moodHappy
        case .sad:
            self.title = "Sad"
            self.description = "Your wife is feeling sad today."
            self.icon = .moodSad
        case .tired:
            self.title = "Tired"
            self.description = "Your wife is feeling so tired of today."
            self.icon = .moodTired
        case .worried:
            self.title = "Worried"
            self.description = "Your wife is feeling worried about today."
            self.icon = .moodWorried
        }
    }
    
}

extension MoodDomain {
    
    static let happy = MoodDomain(type: .happy)
    static let excited = MoodDomain(type: .excited)
    static let tired = MoodDomain(type: .tired)
    static let worried = MoodDomain(type: .worried)
    static let sad = MoodDomain(type: .sad)
    static let angry = MoodDomain(type: .angry)
    
}
