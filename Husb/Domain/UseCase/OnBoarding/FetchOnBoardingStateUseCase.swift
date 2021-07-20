//
//  FetchOnBoardingStateUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation

struct FetchOnBoardingStateUseCaseResponse {
    let onboardingState: OnboardingState?
}

struct FetchOnBoardingStateUseCaseRequest {
}

protocol FetchOnBoardingStateUseCase {
    func execute(_ request: FetchOnBoardingStateUseCaseRequest,
                 completion: @escaping (Result<FetchOnBoardingStateUseCaseResponse, Error>) -> Void)
}

final class DefaultFetchOnBoardingStateUseCase {

    let userDefaultStorage: UserDefaultStorage
    
    public init(
        userDefaultStorage: UserDefaultStorage = UserDefaultStorage.shared
    ) {
        self.userDefaultStorage = userDefaultStorage
    }

}

extension DefaultFetchOnBoardingStateUseCase: FetchOnBoardingStateUseCase {

    public func execute(_ request: FetchOnBoardingStateUseCaseRequest,
                        completion: @escaping (Result<FetchOnBoardingStateUseCaseResponse, Error>) -> Void) {
        if let value = self.userDefaultStorage.getValue(forKey: .userOnboardingState) as? Int {
            let onboardingState = OnboardingState(rawValue: value)
            let response = FetchOnBoardingStateUseCaseResponse(onboardingState: onboardingState)
            completion(.success(response))
        } else {
            let response = FetchOnBoardingStateUseCaseResponse(onboardingState: nil)
            completion(.success(response))
        }
    }
    
}
