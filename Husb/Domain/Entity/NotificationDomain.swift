//
//  NotificationDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

struct NotificationDomain {
    
    enum NotificationType: String {
        case message = "MESSAGE"
        case challengeRequest = "CHALLENGE_REQUEST"
        case completedChallenge = "COMPLETED_CHALLENGE"
    }
    
    var id: String = UUID().uuidString
    var notificationType: NotificationType
    var title: String
    var message: String
    var challengeId: String?
    var date: Date
    var isRead: Bool = false
    var senderId: String = ""
    var receiverId: String = ""
    
}


extension NotificationDomain {
    
    
}
