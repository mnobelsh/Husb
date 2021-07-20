//
//  SaveUserChallengeUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import CloudKit

struct SaveUserChallengeUseCaseResponse {
    let challenge: ChallengeDomain?
}

struct SaveUserChallengeUseCaseRequest {
    let userIds: [String]
    let challenge: ChallengeDomain
}

protocol SaveUserChallengeUseCase {
    func execute(_ request: SaveUserChallengeUseCaseRequest,
                 completion: @escaping (Result<SaveUserChallengeUseCaseResponse, Error>) -> Void)
}

final class DefaultSaveUserChallengeUseCase {

    let remoteService: RemoteService
    let fetchUserUseCase: FetchUserUseCase
    
    init(
        remoteService: RemoteService = RemoteService.shared,
        fetchUserUseCase: FetchUserUseCase = DefaultFetchUserUseCase(remoteService: RemoteService.shared)
    ) {
        self.remoteService = remoteService
        self.fetchUserUseCase = fetchUserUseCase
    }

}

extension DefaultSaveUserChallengeUseCase: SaveUserChallengeUseCase {

    func execute(_ request: SaveUserChallengeUseCaseRequest,
                        completion: @escaping (Result<SaveUserChallengeUseCaseResponse, Error>) -> Void) {
        
        let dispatchQueue = DispatchQueue.global(qos: .background)
        let dispatchGroup = DispatchGroup()
        var currentUserRecord: CKRecord?
        
        dispatchQueue.async(group: dispatchGroup) {
            dispatchGroup.enter()
            self.fetchUserUseCase.execute(.init(parameter: .current)) { result in
                switch result {
                case .success(let response):
                    let predicate = NSPredicate(format: "\(User.idKey) == %@", response.user?.id ?? "")
                    let query = CKQuery(recordType: .profiles, predicate: predicate)
                    self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                        if let record = records?.first {
                            currentUserRecord = record
                        }
                        dispatchGroup.leave()
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) {
            let userPredicate = NSPredicate(format: "\(User.idKey) IN %@", request.userIds)
            let userQuery = CKQuery(recordType: .profiles, predicate: userPredicate)
            self.remoteService.publicDatabase.perform(userQuery, inZoneWith: nil) { records, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let records = records else { return completion(.success(.init(challenge: nil)))}
                    let challenge = request.challenge.toRemote()
                    let parentReferences = records.map({CKRecord.Reference(record: $0, action: .deleteSelf)})
                    guard let currentUserRecord = currentUserRecord else { return }
                    let predicate = NSPredicate(format: "\(Challenge.idKey) == %@ && \(Challenge.userKey) CONTAINS %@", request.challenge.id, currentUserRecord)
                    let query = CKQuery(recordType: .challenges, predicate: predicate)
                    self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                        var insertedRecord: CKRecord
                        if let record = records?.first {
                            insertedRecord = challenge.synchronizeRecord(from: record)
                        } else {
                            insertedRecord = challenge.toRecord()
                        }
                        insertedRecord.setValue(parentReferences, forKey: Challenge.userKey)
                        self.remoteService.publicDatabase.save(insertedRecord) { _, error in
                            if let error = error {
                                completion(.failure(error))
                            } else {
                                self.saveFunFactRecord(challenge, parentRecord: insertedRecord) { result in
                                    switch result {
                                    case .failure(let error):
                                        completion(.failure(error))
                                    case .success:
                                        self.saveChallengeStepsRecord(challenge, parentRecord: insertedRecord) { result in
                                            switch result {
                                            case .failure(let error):
                                                completion(.failure(error))
                                            case .success:
                                                completion(.success(.init(challenge: request.challenge)))
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    private func saveFunFactRecord(
        _ challenge: Challenge,
        parentRecord: CKRecord,
        completion: @escaping (Result<Challenge, Error>) -> Void
    ) {
        guard let funFact = challenge.funFact else { return }
        let predicate = NSPredicate(format: "\(FunFact.idKey) == %@", funFact.id)
        let query = CKQuery(recordType: .funFact, predicate: predicate)
        self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
            var insertedRecord: CKRecord
            if let record = records?.first {
                insertedRecord = funFact.synchronizeRecord(from: record)
            } else {
                insertedRecord = funFact.toRecord()
            }
            let parentReference = CKRecord.Reference(record: parentRecord, action: .deleteSelf)
            insertedRecord.setValue(parentReference, forKey: FunFact.challengeKey)
            self.remoteService.publicDatabase.save(insertedRecord) { _, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(challenge))
                }
            }
        }
        
        

    }
    
    private func saveChallengeStepsRecord(
        _ challenge: Challenge,
        parentRecord: CKRecord,
        completion: @escaping (Result<Challenge, Error>) -> Void
    ) {
        challenge.steps?.forEach { step in
            let predicate = NSPredicate(format: "\(ChallengeStep.idKey) == %@", step.id)
            let query = CKQuery(recordType: .challengeSteps, predicate: predicate)
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                var insertedRecord: CKRecord
                if let record = records?.first {
                    insertedRecord = step.synchronizeRecord(from: record)
                } else {
                    insertedRecord = step.toRecord()
                }
                let parentReference = CKRecord.Reference(record: parentRecord, action: .deleteSelf)
                insertedRecord.setValue(parentReference, forKey: ChallengeStep.challengeKey)
                self.remoteService.publicDatabase.save(insertedRecord) { _, error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(challenge))
                    }
                }
            }
        }
    }
    
}
