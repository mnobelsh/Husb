//
//  RoleDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import Foundation


struct RoleDomain {
    
    enum RoleType: String {
        case hubby = "HUBBY"
        case wife = "WIFE"
        case couple = "COUPLE"
    }
    
    var id: String = UUID().uuidString
    var type: RoleType
    var title: String
        
    init(type: RoleType) {
        self.type = type
        switch type {
        case .couple:
            self.title = "Couple"
        case .hubby:
            self.title = "Hubby"
        case .wife:
            self.title = "Wifey"
        }
    }
    
}

extension RoleDomain {
    
    static let hubby = RoleDomain(type: .hubby)
    static let wife = RoleDomain(type: .wife)
    static let couple = RoleDomain(type: .couple)
    
}
