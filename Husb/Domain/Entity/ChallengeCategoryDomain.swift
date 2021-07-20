//
//  ChallengeCategoryDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import Foundation

struct ChallengeCategoryDomain {
    
    var id: String = UUID().uuidString
    var loveLanguage: LoveLanguageDomain
    var role: RoleDomain
    
}
