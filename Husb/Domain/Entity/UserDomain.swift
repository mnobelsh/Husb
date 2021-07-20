//
//  UserDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

struct UserDomain {
    
    var id: String = UUID().uuidString
    var username: String
    var email: String
    var name: String
    var role: RoleDomain
    var connectedUserId: String?
    var challenges: [ChallengeDomain]
    var profileImage: UIImage?
    var password: String
    var mood: MoodDomain?
    
}
