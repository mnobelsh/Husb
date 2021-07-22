//
//  UseCaseFactory.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import Foundation

protocol UseCaseFactory {
    
//    func makeFetchTipsUseCase()
//    
//    func makefetchWifeDailyMoodUseCase()
//    
//    func makefetchNotificationsUseCase()
    
    func saveOnBoardingStateUseCase() -> SaveOnBoardingStateUseCase
    func fetchOnBoardingStateUseCase() -> FetchOnBoardingStateUseCase
    
    func validateIsUserSignedInUseCase() -> ValidateIsUserSignedInUseCase
    func fetchUserUseCase() -> FetchUserUseCase
    func saveUserUseCase() -> SaveUserUseCase
    
    func fetchUserChallengesUseCase() -> FetchUserChallengesUseCase
    func saveUserChallengeUseCase() -> SaveUserChallengeUseCase
    
    func saveNotificationUseCase() -> SaveNotificationUseCase
    func fetchNotificationsUseCase() -> FetchNotificationsUseCase
    
}
