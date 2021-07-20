//
//  Step.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import Foundation
import CloudKit

final class ChallengeStep {
    
    static let idKey = "id"
    static let stepNumberKey = "stepNumber"
    static let descriptionKey = "description"
    static let isDoneKey = "isDone"
    static let challengeKey = "challenge"
    
    var id: String = ""
    var description: String = ""
    var stepNumber: Int = 0
    var isDone: Bool = false
    
}


extension ChallengeStep {
    
    func toDomain() -> ChallengeStepDomain {
        return ChallengeStepDomain(
            id: self.id,
            stepNumber: self.stepNumber,
            description: self.description,
            isDone: self.isDone
        )
    }
    
    @discardableResult
    func synchronizeRecord(from record: CKRecord) -> CKRecord {
        record.setValue(self.stepNumber, forKey: ChallengeStep.stepNumberKey)
        record.setValue(self.description, forKey: ChallengeStep.descriptionKey)
        record.setValue(self.isDone, forKey: ChallengeStep.isDoneKey)
        return record
    }
    
    @discardableResult
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: .challengeSteps)
        record.setValue(self.id, forKey: ChallengeStep.idKey)
        record.setValue(self.stepNumber, forKey: ChallengeStep.stepNumberKey)
        record.setValue(self.description, forKey: ChallengeStep.descriptionKey)
        record.setValue(self.isDone, forKey: ChallengeStep.isDoneKey)
        return record
    }
    
    @discardableResult
    func getChallengStep(from record: CKRecord) -> ChallengeStep {
        let challengeStep = ChallengeStep()
        challengeStep.id = record.value(forKey: ChallengeStep.idKey) as? String ?? ""
        challengeStep.stepNumber = record.value(forKey: ChallengeStep.stepNumberKey) as? Int ?? 0
        challengeStep.description = record.value(forKey: ChallengeStep.descriptionKey) as? String ?? ""
        challengeStep.isDone = record.value(forKey: ChallengeStep.isDoneKey) as? Bool ?? false
        return challengeStep
    }
    
}

extension ChallengeStepDomain {
    
    func toRemote() -> ChallengeStep {
        let challengeStep = ChallengeStep()
        challengeStep.id = self.id
        challengeStep.stepNumber = self.stepNumber
        challengeStep.description = self.description
        challengeStep.isDone = self.isDone
        return challengeStep
    }
    
}
