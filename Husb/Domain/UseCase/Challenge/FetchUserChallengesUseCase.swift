//
//  FetchUserChallengesUseCaseUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//  Copyright (c) 2021 All rights reserved.
//

import Foundation
import CloudKit

struct FetchUserChallengesUseCaseResponse {
    let challenges: [ChallengeDomain]
}

struct FetchUserChallengesUseCaseRequest {
    enum FetchObjective {
        case all
        case byChallengeId(String)
//        case byLoveLanguage(LoveLanguageDomain.LoveLanguageType)
    }
    
    let userId: String
    let objective: FetchObjective
}

protocol FetchUserChallengesUseCase {
    func execute(_ request: FetchUserChallengesUseCaseRequest,
                 completion: @escaping (Result<FetchUserChallengesUseCaseResponse, Error>) -> Void)
}

final class DefaultFetchUserChallengesUseCase {
    
    let remoteService: RemoteService
    let fetchUserUseCase: FetchUserUseCase

    init(
        remoteService: RemoteService = RemoteService.shared,
        fetchUserUseCase: FetchUserUseCase = DefaultFetchUserUseCase()
    ) {
        self.remoteService = remoteService
        self.fetchUserUseCase = fetchUserUseCase
    }

}

extension DefaultFetchUserChallengesUseCase: FetchUserChallengesUseCase {

    func execute(_ request: FetchUserChallengesUseCaseRequest,
                        completion: @escaping (Result<FetchUserChallengesUseCaseResponse, Error>) -> Void) {
        let dispatchQueue = DispatchQueue.global(qos: .background)
        let dispatchGroup = DispatchGroup()
        var challenges: [Challenge] = []
        
        dispatchQueue.async(group: dispatchGroup) {
            dispatchGroup.enter()
            let userPredicate = NSPredicate(format: "\(User.idKey) == %@", request.userId)
            let query = CKQuery(recordType: .profiles, predicate: userPredicate)
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    guard let record = records?.first else { return completion(.success(.init(challenges: [])))}
                    var predicate: NSPredicate
                    let reference = CKRecord.Reference(record: record, action: .deleteSelf)
                    switch request.objective {
                    case .all:
                        predicate = NSPredicate(format: "\(Challenge.userKey) CONTAINS %@", reference)
                    case .byChallengeId(let challengeId):
                        predicate = NSPredicate(format: "\(Challenge.idKey) == %@ && \(Challenge.userKey) CONTAINS %@", challengeId, reference)
                    }
                    let query = CKQuery(recordType: .challenges, predicate: predicate)
                    self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            if let records = records, records.count > 0 {
                                records.forEach { record in
                                    let challenge = Challenge().getChallenge(from: record)
                                    self.fetchFunFact(from: record) { result in
                                        challenge.funFact = try? result.get()
                                        self.fetchChallengeSteps(from: record) { result in
                                            challenge.steps =  try? result.get()
                                            challenges.append(challenge)
                                            if challenges.count == records.count {
                                                dispatchGroup.leave()
                                            }
                                        }
                                    }
                                }
                            } else {
                                dispatchGroup.leave()
                            }
                        }
                    }
                }
            }
        }

        dispatchGroup.notify(queue: dispatchQueue) {
            completion(
                .success(
                    .init(challenges: challenges.map({ $0.toDomain() }))
                )
            )
        }
    }
    
    private func fetchFunFact(
        from parentRecord: CKRecord,
        completion: @escaping(Result<FunFact?, Error>) -> Void
    ) {
        let reference = CKRecord.Reference(record: parentRecord, action: .deleteSelf)
        let predicate = NSPredicate(format: "\(FunFact.challengeKey) == %@", reference)
        let query = CKQuery(recordType: .funFact, predicate: predicate)
        self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let record = records?.first {
                    let funFact = FunFact().getFunFact(from: record)
                    completion(.success(funFact))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
    
    private func fetchChallengeSteps(
        from parentRecord: CKRecord,
        completion: @escaping(Result<[ChallengeStep]?, Error>) -> Void
    ) {
        let reference = CKRecord.Reference(record: parentRecord, action: .deleteSelf)
        let predicate = NSPredicate(format: "\(ChallengeStep.challengeKey) == %@", reference)
        let query = CKQuery(recordType: .challengeSteps, predicate: predicate)
        self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
            if let error = error {
                completion(.failure(error))
            } else {
                if let records = records {
                    let challengeSteps = records.compactMap({ChallengeStep().getChallengStep(from: $0)})
                    completion(.success(challengeSteps))
                } else {
                    completion(.success(nil))
                }
            }
        }
    }
    
}
