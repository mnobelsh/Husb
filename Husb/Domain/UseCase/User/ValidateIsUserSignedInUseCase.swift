//
//  ValidateIsUserSignedInUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation


struct ValidateIsUserSignedInUseCaseResponse {
    var userId: String?
}

struct ValidateIsUserSignedInUseCaseRequest {

}

protocol ValidateIsUserSignedInUseCase {
    func execute(_ request: ValidateIsUserSignedInUseCaseRequest,
                 completion: @escaping (Result<ValidateIsUserSignedInUseCaseResponse, Error>) -> Void)
}

final class DefaultValidateIsUserSignedInUseCase {

    var userDefaultStorage: UserDefaultStorage
    
    init(
        userDefaultStorage: UserDefaultStorage = UserDefaultStorage.shared
    ) {
        self.userDefaultStorage = userDefaultStorage
    }

}

extension DefaultValidateIsUserSignedInUseCase: ValidateIsUserSignedInUseCase {

    func execute(_ request: ValidateIsUserSignedInUseCaseRequest,
                        completion: @escaping (Result<ValidateIsUserSignedInUseCaseResponse, Error>) -> Void) {
        completion(
            .success(.init(userId: self.userDefaultStorage.getValue(forKey: .currentUserId) as? String))
        )
    }
    
}
