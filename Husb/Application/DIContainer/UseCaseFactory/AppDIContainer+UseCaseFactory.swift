//
//  AppDIContainer+UseCaseFactory.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import Foundation

extension AppDIContainer: UseCaseFactory {
    
    func saveNotificationUseCase() -> SaveNotificationUseCase {
        return DefaultSaveNotificationUseCase()
    }
    
    func fetchNotificationsUseCase() -> FetchNotificationsUseCase {
        return DefaultFetchNotificationsUseCase()
    }
    
    
    func validateIsUserSignedInUseCase() -> ValidateIsUserSignedInUseCase {
        return DefaultValidateIsUserSignedInUseCase()
    }
    
    func fetchUserUseCase() -> FetchUserUseCase {
        return DefaultFetchUserUseCase()
    }
    
    func saveUserUseCase() -> SaveUserUseCase {
        return DefaultSaveUserUseCase()
    }
    
    func fetchUserChallengesUseCase() -> FetchUserChallengesUseCase {
        return DefaultFetchUserChallengesUseCase()
    }
    
    func saveUserChallengeUseCase() -> SaveUserChallengeUseCase {
        return DefaultSaveUserChallengeUseCase()
    }
    
    func saveOnBoardingStateUseCase() -> SaveOnBoardingStateUseCase {
        return DefaultSaveOnBoardingStateUseCase()
    }
    
    func fetchOnBoardingStateUseCase() -> FetchOnBoardingStateUseCase {
        return DefaultFetchOnBoardingStateUseCase()
    }
    
}
