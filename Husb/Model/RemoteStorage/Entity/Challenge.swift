//
//  Challenge.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import UIKit
import CloudKit

final class Challenge {
    
    static let idKey = "id"
    static let titleKey = "title"
    static let descriptionKey = "description"
    static let loveLanguageKey = "loveLanguage"
    static let roleKey = "role"
    static let stepsKey = "steps"
    static let isActiveKey = "isActive"
    static let funFactKey = "funFact"
    static let isCompletedKey = "isCompleted"
    static let dueDateKey = "dueDate"
    static let addedDateKey = "addedDate"
    static let posterImageDataKey = "posterImageData"
    static let momentImageDataKey = "momentImageData"
    static let userKey = "users"
    
    var id: String = ""
    var title: String = ""
    var description: String = ""
    var loveLanguage: String = ""
    var role: String = ""
    var steps: [ChallengeStep]?
    var isActive: Bool = false
    var funFact: FunFact?
    var isCompleted: Bool = false
    var dueDate: Date?
    var addedDate: Date?
    var posterImageData: Data?
    var momentImageData: Data?
    
}

extension Challenge {
    
    @discardableResult
    func toDomain() -> ChallengeDomain {
        return ChallengeDomain(
            id: self.id,
            title: self.title,
            description: self.description,
            loveLanguage: LoveLanguageDomain(type: LoveLanguageDomain.LoveLanguageType(rawValue: self.loveLanguage) ?? .actOfService),
            role: RoleDomain(type: RoleDomain.RoleType(rawValue: self.role) ?? .couple),
            steps: self.steps?.compactMap({$0.toDomain()}).sorted(by: {$0.stepNumber < $1.stepNumber}) ?? [],
            isActive: self.isActive,
            funFact: self.funFact?.toDomain(),
            isCompleted: self.isCompleted,
            dueDate: self.dueDate,
            addedDate: self.addedDate,
            posterImage: UIImage(data: self.posterImageData ?? Data()),
            momentImage: UIImage(data: self.momentImageData ?? Data())
        )
    }
    
    @discardableResult
    func synchronizeRecord(from record: CKRecord) -> CKRecord {
        record.setValue(self.title, forKey: Challenge.titleKey)
        record.setValue(self.description, forKey: Challenge.descriptionKey)
        record.setValue(self.loveLanguage, forKey: Challenge.loveLanguageKey)
        record.setValue(self.role, forKey: Challenge.roleKey)
        record.setValue(self.isActive, forKey: Challenge.isActiveKey)
        record.setValue(self.isCompleted, forKey: Challenge.isCompletedKey)
        record.setValue(self.dueDate, forKey: Challenge.dueDateKey)
        record.setValue(self.posterImageData, forKey: Challenge.posterImageDataKey)
        record.setValue(self.momentImageData, forKey: Challenge.momentImageDataKey)
        return record
    }
    
    @discardableResult
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: .challenges)
        record.setValue(self.id, forKey: Challenge.idKey)
        record.setValue(self.title, forKey: Challenge.titleKey)
        record.setValue(self.description, forKey: Challenge.descriptionKey)
        record.setValue(self.loveLanguage, forKey: Challenge.loveLanguageKey)
        record.setValue(self.role, forKey: Challenge.roleKey)
        record.setValue(self.isActive, forKey: Challenge.isActiveKey)
        record.setValue(self.isCompleted, forKey: Challenge.isCompletedKey)
        record.setValue(self.dueDate, forKey: Challenge.dueDateKey)
        record.setValue(self.addedDate, forKey: Challenge.addedDateKey)
        record.setValue(self.posterImageData, forKey: Challenge.posterImageDataKey)
        record.setValue(self.momentImageData, forKey: Challenge.momentImageDataKey)
        return record
    }
    
    @discardableResult
    func getChallenge(from record: CKRecord) -> Challenge {
        let challenge = Challenge()
        challenge.id = record.value(forKey: Challenge.idKey) as? String ?? ""
        challenge.title = record.value(forKey: Challenge.titleKey) as? String ?? ""
        challenge.description = record.value(forKey: Challenge.descriptionKey) as? String ?? ""
        challenge.loveLanguage = record.value(forKey: Challenge.loveLanguageKey) as? String ?? ""
        challenge.role = record.value(forKey: Challenge.roleKey) as? String ?? ""
        challenge.isActive = record.value(forKey: Challenge.isActiveKey) as? Bool ?? false
        challenge.isCompleted = record.value(forKey: Challenge.isCompletedKey) as? Bool ?? false
        challenge.dueDate = record.value(forKey: Challenge.dueDateKey) as? Date
        challenge.addedDate = record.value(forKey: Challenge.addedDateKey) as? Date ?? Date()
        challenge.posterImageData = record.value(forKey: Challenge.posterImageDataKey) as? Data
        challenge.momentImageData = record.value(forKey: Challenge.momentImageDataKey) as? Data
        return challenge
    }
    
}

extension ChallengeDomain {
    
    func toRemote() -> Challenge {
        let challenge = Challenge()
        challenge.id = self.id
        challenge.title = self.title
        challenge.description = self.description
        challenge.loveLanguage = self.loveLanguage.type.rawValue
        challenge.role = self.role.type.rawValue
        challenge.steps = self.steps.compactMap({$0.toRemote()})
        challenge.isActive = self.isActive
        challenge.funFact = self.funFact?.toRemote()
        challenge.isCompleted = self.isCompleted
        challenge.dueDate = self.dueDate
        challenge.addedDate = self.addedDate
        challenge.posterImageData = self.posterImage?.data()
        challenge.momentImageData = self.momentImage?.data()
        return challenge
    }
    
}


