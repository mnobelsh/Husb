//
//  UIImage.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

fileprivate extension String {
    
    static let challengeTabBarIcon = "tray.full.fill"
    static let exploreTabBarIcon = "magnifyingglass"
    static let calendarTabBarIcon = "calendar"
    static let notificationTabBarIcon = "bell"
    static let bookmarkFill = "bookmark.fill"
    static let checkMark = "checkmark"
    static let chevronLeft = "chevronLeft"
    static let chevronDown = "chevronDown"
    static let chevronRight = "chevronRight"
    static let qrCodeIcon = "qrCodeIcon"
    static let messageBlue = "messageBlue"
    static let messageYellow = "messageYellow"
    static let heartCircle = "heartCircle"
    static let starCircle = "starCircle"
    static let wifeyIcon = "wifeyIcon"
    static let qrBackground = "qrBackground"
    static let hubbyIcon = "hubbyIcon"
    static let defaultOnBoarding = "defaultOnBoarding"
    static let bubbleCheck = "bubbleCheck"
    static let signInGreetings = "signInGreetings"
    
}

extension UIImage {
    
    static let challengeIcon = UIImage(systemName: .challengeTabBarIcon)!
    static let exploreIcon = UIImage(systemName: .exploreTabBarIcon)!
    static let calendarIcon = UIImage(systemName: .calendarTabBarIcon)!
    static let notificationIcon = UIImage(systemName: .notificationTabBarIcon)!
    static let bookmarkIcon = UIImage(systemName: .bookmarkFill)!
    static let checkMarkIcon = UIImage(systemName: .checkMark)!
    static let chevronLeft = UIImage(named: .chevronLeft)!
    static let chevronDown = UIImage(named: .chevronDown)!
    static let chevronRight = UIImage(named: .chevronRight)!
    static let qrCodeIcon = UIImage(named: .qrCodeIcon)!
    static let person = UIImage(systemName: "person")!
    static let messageBlue = UIImage(named: .messageBlue)!
    static let messageYellow = UIImage(named: .messageYellow)!
    static let heartCircle = UIImage(named: .heartCircle)!
    static let xmarkCircleFill = UIImage(systemName: "xmark.circle.fill")!
    static let starCircle = UIImage(named: .starCircle)!
    static let wifeyIcon = UIImage(named: .wifeyIcon)!
    static let hubbyIcon = UIImage(named: .hubbyIcon)!
    static let qrBackground = UIImage(named: .qrBackground)!
    static let defaultOnBoarding = UIImage(named: .defaultOnBoarding)!
    static let bubbleCheck = UIImage(named: .bubbleCheck)!
    static let signInGreetings = UIImage(named: .signInGreetings)!
    static let actsOfService = UIImage(named: "actsOfService")!
    static let givingGifts = UIImage(named: "givingGifts")!
    static let physicalTouch = UIImage(named: "physicalTouch")!
    static let qualityTime = UIImage(named: "qualityTime")!
    static let wordsOfAffirmation = UIImage(named: "wordsOfAffirmation")!
    static let onboardingAppreciation = UIImage(named: "onboardingAppreciation")!
    static let onboardingChallenge = UIImage(named: "onboardingChallenge")!
    static let onboardingConnect = UIImage(named: "onboardingConnect")!
    static let simpleThingsGiveHerAHug = UIImage(named: "simpleThingsGiveHerAHug")!
    static let simpleThingsGiveHerAKiss = UIImage(named: "simpleThingsGiveHerAKiss")!
    static let simpleThingsNightTimeCuddle = UIImage(named: "simpleThingsNightTimeCuddle")!
    static let moodAngry = UIImage(named: "moodAngry")!
    static let moodExcited = UIImage(named: "moodExcited")!
    static let moodHappy = UIImage(named: "moodHappy")!
    static let moodSad = UIImage(named: "moodSad")!
    static let moodTired = UIImage(named: "moodTired")!
    static let moodWorried = UIImage(named: "moodWorried")!
    static let noChallenge = UIImage(named: "noChallenge")!
    static let customChallenge = UIImage(named: "customChallenge")!
    static let appLogo = UIImage(named: "appLogo")!
    
}


extension UIImage {
    
    func data() -> Data? {
        if let pngData = self.pngData() {
            return pngData
        } else if let jpegData = self.jpegData(compressionQuality: .leastNormalMagnitude) {
            return jpegData
        }
        return nil
    }
    
    
}
