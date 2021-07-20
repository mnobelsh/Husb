//
//  NotificationDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

struct NotificationDomain {
    
    enum NotificationType {
        case message
        case challengeRequest
    }
    
    var id: String = UUID().uuidString
    var notificationType: NotificationType
    var message: MessageDomain?
    var challenge: ChallengeDomain?
    var date: Date
    var isRead: Bool = false
    
}


extension NotificationDomain {
    
    
    static let list: [NotificationDomain] = [
        .init(
            notificationType: .message,
            message: .init(
                title: "Message From Your Wife",
                message: "Thank you for always trying your best to be the best husband for me. I really appreciate everything that you did for me and our little ones. Please be home soon. I miss you "),
            date: Date()
        ),
        .init(
            notificationType: .challengeRequest,
            challenge: ChallengeDomain.actOfService.first!,
            date: Date()
        )
    ]
    
}
