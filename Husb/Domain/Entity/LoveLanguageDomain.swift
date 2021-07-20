//
//  LoveLanguageDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

struct LoveLanguageDomain {
    
    enum LoveLanguageType: String, CaseIterable {
        case actOfService = "ACT_OF_SERVICE"
        case wordsOfAffirmation = "WORD_OF_AFFIRMATION"
        case qualityTime = "QUALITY_TIME"
        case physicalTouch = "PHYSICAL_TOUCH"
        case givingGifts = "GIVING_GIFTS"
    }
    
    var id: String = UUID().uuidString
    var type: LoveLanguageType
    var title: String
    var posterImage: UIImage?
    
    init(type: LoveLanguageType) {
        self.type = type
        switch self.type {
            case .actOfService:
                self.title = "Act of Service"
                self.posterImage = .actsOfService
            case .wordsOfAffirmation:
                self.title = "Words of Affirmation"
                self.posterImage = .wordsOfAffirmation
            case .qualityTime:
                self.title = "Quality Time"
                self.posterImage = .qualityTime
            case .physicalTouch:
                self.title = "Physical Touch"
                self.posterImage = .physicalTouch
            case .givingGifts:
                self.title = "Giving Gifts"
                self.posterImage = .givingGifts
        }
    }
    
}

extension LoveLanguageDomain {
    
    static let list: [LoveLanguageDomain] = [
        .actOfService,
        .physicalTouch,
        .qualityTime,
        .wordsOfAffirmation,
        .givingGifts
    ]
    
    static let actOfService: LoveLanguageDomain = .init(type: .actOfService)
    static let wordsOfAffirmation: LoveLanguageDomain = .init(type: .wordsOfAffirmation)
    static let qualityTime: LoveLanguageDomain = .init(type: .qualityTime)
    static let physicalTouch: LoveLanguageDomain = .init(type: .physicalTouch)
    static let givingGifts: LoveLanguageDomain = .init(type: .givingGifts)

}
