//
//  User.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import UIKit
import CloudKit

final class User {
    
    static let idKey = "id"
    static let usernameKey = "username"
    static let emailKey = "email"
    static let nameKey = "name"
    static let roleKey = "role"
    static let connectedUserIdKey = "connectedUserId"
    static let profileImageDataKey = "profileImageData"
    static let passwordKey = "password"
    static let moodKey = "mood"
    
    var id: String = ""
    var username: String = ""
    var email: String = ""
    var name: String = ""
    var role: String = ""
    var connectedUserId: String?
    var profileImageData: Data?
    var password: String = ""
    var mood: String?
    
}

extension User {
    
    @discardableResult
    func toDomain() -> UserDomain {
        var moodDomain: MoodDomain? = nil
        if let mood = self.mood {
            moodDomain = MoodDomain(
                type: MoodDomain.MoodType(rawValue: mood) ?? .happy
            )
        }
        return UserDomain(
            id: self.id,
            username: self.username,
            email: self.email,
            name: self.name,
            role: RoleDomain(type: RoleDomain.RoleType(rawValue: self.role) ?? .couple),
            connectedUserId: self.connectedUserId,
            challenges: [],
            profileImage: UIImage(data: self.profileImageData ?? Data()),
            password: self.password,
            mood: moodDomain
        )
    }
    
    @discardableResult
    func synchronizeRecord(from record: CKRecord) -> CKRecord {
        record.setValue(self.username, forKey: User.usernameKey)
        record.setValue(self.email, forKey: User.emailKey)
        record.setValue(self.name, forKey: User.nameKey)
        record.setValue(self.role, forKey: User.roleKey)
        record.setValue(self.connectedUserId, forKey: User.connectedUserIdKey)
        record.setValue(self.profileImageData, forKey: User.profileImageDataKey)
        record.setValue(self.password, forKey: User.passwordKey)
        record.setValue(self.mood, forKey: User.moodKey)
        return record
    }
    
    @discardableResult
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: .profiles)
        record.setValue(self.id, forKey: Challenge.idKey)
        record.setValue(self.username, forKey: User.usernameKey)
        record.setValue(self.email, forKey: User.emailKey)
        record.setValue(self.name, forKey: User.nameKey)
        record.setValue(self.role, forKey: User.roleKey)
        record.setValue(self.connectedUserId, forKey: User.connectedUserIdKey)
        record.setValue(self.profileImageData, forKey: User.profileImageDataKey)
        record.setValue(self.password, forKey: User.passwordKey)
        record.setValue(self.mood, forKey: User.moodKey)
        return record
    }
    
    @discardableResult
    func getUser(from record: CKRecord) -> User {
        let user = User()
        user.id = record.value(forKey: Challenge.idKey) as? String ?? ""
        user.username = record.value(forKey: User.usernameKey) as? String ?? ""
        user.email = record.value(forKey: User.emailKey) as? String ?? ""
        user.name = record.value(forKey: User.nameKey) as? String ?? ""
        user.role = record.value(forKey: User.roleKey) as? String ?? ""
        user.connectedUserId = record.value(forKey: User.connectedUserIdKey) as? String
        user.profileImageData = record.value(forKey:  User.profileImageDataKey) as? Data
        user.password = record.value(forKey: User.passwordKey) as? String ?? ""
        user.mood = record.value(forKey: User.moodKey) as? String
        return user
    }
    
    
}

extension UserDomain {
    
    func toRemote() -> User {
        let user = User()
        user.id = self.id
        user.username = self.username
        user.email = self.email
        user.name = self.name
        user.role = self.role.type.rawValue
        user.connectedUserId = self.connectedUserId
        user.profileImageData = self.profileImage?.jpegData(compressionQuality: .leastNormalMagnitude)
        user.password = self.password
        user.mood = self.mood?.type.rawValue
        return user
    }
    
}
