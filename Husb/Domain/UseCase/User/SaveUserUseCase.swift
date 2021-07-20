//
//  SaveUserUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import CloudKit


struct SaveUserUseCaseResponse {
    let user: UserDomain
}

struct SaveUserUseCaseRequest {
    let user: UserDomain
}

protocol SaveUserUseCase {
    func execute(_ request: SaveUserUseCaseRequest,
                 completion: @escaping (Result<SaveUserUseCaseResponse, Error>) -> Void)
}

final class DefaultSaveUserUseCase {

    let remoteService: RemoteService
    let userDefaultStorage: UserDefaultStorage
    
    init(
        remoteService: RemoteService = RemoteService.shared,
        userDefaultStorage: UserDefaultStorage = UserDefaultStorage.shared
    ) {
        self.remoteService = remoteService
        self.userDefaultStorage = userDefaultStorage
    }

}

extension DefaultSaveUserUseCase: SaveUserUseCase {

    func execute(_ request: SaveUserUseCaseRequest,
                        completion: @escaping (Result<SaveUserUseCaseResponse, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let predicate = NSPredicate(format: "\(User.idKey) == %@", request.user.id)
            let query = CKQuery(recordType: .profiles, predicate: predicate)
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                var insertedRecord: CKRecord
                let user = request.user.toRemote()
                if let record = records?.first {
                    insertedRecord = user.synchronizeRecord(from: record)
                } else {
                    insertedRecord = user.toRecord()
                }
                self.remoteService.publicDatabase.save(insertedRecord) { savedRecord, error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self.userDefaultStorage.setValue(request.user.id, forKey: .currentUserId)
                        completion(.success(.init(user: request.user)))
                    }
                }
            }
        }
    }
    
}
