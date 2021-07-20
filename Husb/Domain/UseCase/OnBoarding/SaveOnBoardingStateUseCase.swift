//
//  SaveOnBoardingStateUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

enum OnboardingState: Int {
    case undone = 0
    case done = 1
}

struct SaveOnBoardingStateUseCaseResponse {
    let onboardingState: OnboardingState
}

struct SaveOnBoardingStateUseCaseRequest {
    let onboardingState: OnboardingState
}

protocol SaveOnBoardingStateUseCase {
    func execute(_ request: SaveOnBoardingStateUseCaseRequest,
                 completion: @escaping (Result<SaveOnBoardingStateUseCaseResponse, Error>) -> Void)
}

final class DefaultSaveOnBoardingStateUseCase {
    
    let userDefaultStorage: UserDefaultStorage

    public init(
        userDefaultStorage: UserDefaultStorage = UserDefaultStorage.shared
    ) {
        self.userDefaultStorage = userDefaultStorage
    }

}

extension DefaultSaveOnBoardingStateUseCase: SaveOnBoardingStateUseCase {

    public func execute(_ request: SaveOnBoardingStateUseCaseRequest,
                        completion: @escaping (Result<SaveOnBoardingStateUseCaseResponse, Error>) -> Void) {
        self.userDefaultStorage.setValue(request.onboardingState.rawValue, forKey: .userOnboardingState)
        completion(.success(.init(onboardingState: request.onboardingState)))
    }
    
}
