//
//  FetchUserUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import CloudKit

struct FetchUserUseCaseResponse {
    let user: UserDomain?
}

struct FetchUserUseCaseRequest {
    enum Parameter {
        case byId(userId: String)
        case auth(username: String)
        case current
    }
    let parameter: Parameter
}

protocol FetchUserUseCase {
    func execute(_ request: FetchUserUseCaseRequest,
                 completion: @escaping (Result<FetchUserUseCaseResponse, Error>) -> Void)
}

final class DefaultFetchUserUseCase {

    let remoteService: RemoteService
    
    init(
        remoteService: RemoteService = RemoteService.shared
    ) {
        self.remoteService = remoteService
    }

}

extension DefaultFetchUserUseCase: FetchUserUseCase {

    func execute(_ request: FetchUserUseCaseRequest,
                        completion: @escaping (Result<FetchUserUseCaseResponse, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var predicate = NSPredicate()
            switch request.parameter {
            case .auth(let username):
                predicate = NSPredicate(format: "\(User.usernameKey) == %@", username)
            case .byId(let userId):
                predicate = NSPredicate(format: "\(User.idKey) == %@", userId)
            case .current:
                guard let userId = UserDefaultStorage.shared.getValue(forKey: .currentUserId) as? String else {
                    return completion(.success(.init(user: nil)))
                }
                predicate = NSPredicate(format: "\(User.idKey) == %@", userId)
            }
            let query = CKQuery(recordType: .profiles, predicate: predicate)
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                if let record = records?.first {
                    let user = User().getUser(from: record).toDomain()
                    completion(.success(.init(user: user)))
                } else {
                    completion(.success(.init(user: nil)))
                }
            }
        }
    }
    
}
