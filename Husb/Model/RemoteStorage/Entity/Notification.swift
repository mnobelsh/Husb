//
//  Notification.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/07/21.
//

import Foundation
import CoreData

class Notification {
    
    static let idKey = "id"
    static let notificationTypeKey = "notificationType"
    static let titleKey = "title"
    static let messageKey = "message"
    static let challengeIdKey = "challengeId"
    static let dateKey = "date"
    static let isReadKey = "isRead"
    static let senderIdKey = "senderId"
    static let receiverIdKey = "receiverId"
    
    var id: String = UUID().uuidString
    var notificationType: String = ""
    var title: String = ""
    var message: String = ""
    var challengeId: String?
    var date: Date = Date()
    var isRead: Bool = false
    var senderId: String = ""
    var receiverId: String = ""
    
}

extension Notification {
    
    @discardableResult
    func toDomain() -> NotificationDomain {
        return NotificationDomain(
            id: self.id,
            notificationType: NotificationDomain.NotificationType(rawValue: self.notificationType) ?? .message,
            title: self.title,
            message: self.message,
            challengeId: self.challengeId,
            date: self.date,
            isRead: self.isRead,
            senderId: self.senderId,
            receiverId: self.receiverId
        )
    }
    
    @discardableResult
    func synchronizeRecord(from record: CKRecord) -> CKRecord {
        record.setValue(self.notificationType, forKey: Notification.notificationTypeKey)
        record.setValue(self.title, forKey: Notification.titleKey)
        record.setValue(self.message, forKey: Notification.messageKey)
        record.setValue(self.challengeId, forKey: Notification.challengeIdKey)
        record.setValue(self.date, forKey: Notification.dateKey)
        record.setValue(self.isRead, forKey: Notification.isReadKey)
        record.setValue(self.senderId, forKey: Notification.senderIdKey)
        record.setValue(self.receiverId, forKey: Notification.receiverIdKey)
        return record
    }
    
    @discardableResult
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: .notifications)
        record.setValue(self.id, forKey: Notification.idKey)
        record.setValue(self.notificationType, forKey: Notification.notificationTypeKey)
        record.setValue(self.title, forKey: Notification.titleKey)
        record.setValue(self.message, forKey: Notification.messageKey)
        record.setValue(self.challengeId, forKey: Notification.challengeIdKey)
        record.setValue(self.date, forKey: Notification.dateKey)
        record.setValue(self.isRead, forKey: Notification.isReadKey)
        record.setValue(self.senderId, forKey: Notification.senderIdKey)
        record.setValue(self.receiverId, forKey: Notification.receiverIdKey)
        return record
    }
    
    @discardableResult
    func getNotification(from record: CKRecord) -> Notification {
        let notificaiton = Notification()
        notificaiton.id = record.value(forKey: Notification.idKey) as? String ?? ""
        notificaiton.notificationType = record.value(forKey: Notification.notificationTypeKey) as? String ?? ""
        notificaiton.title = record.value(forKey: Notification.titleKey) as? String ?? ""
        notificaiton.message = record.value(forKey: Notification.messageKey) as? String ?? ""
        notificaiton.challengeId = record.value(forKey: Notification.challengeIdKey) as? String
        notificaiton.date = record.value(forKey: Notification.dateKey) as? Date ?? Date()
        notificaiton.isRead = record.value(forKey: Notification.isReadKey) as? Bool ?? false
        notificaiton.senderId = record.value(forKey: Notification.senderIdKey) as? String ?? ""
        notificaiton.receiverId = record.value(forKey: Notification.receiverIdKey) as? String ?? ""
        return notificaiton
    }
    
    
}

extension NotificationDomain {
    
    @discardableResult
    func toRemote() -> Notification {
        let notification = Notification()
        notification.id = self.id
        notification.notificationType = self.notificationType.rawValue
        notification.title = self.title
        notification.message = self.message
        notification.challengeId = self.challengeId
        notification.date = self.date
        notification.isRead = self.isRead
        notification.senderId = self.senderId
        notification.receiverId = self.receiverId
        return notification
    }
    
}
