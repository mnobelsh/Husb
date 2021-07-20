//
//  FunFactDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 03/07/21.
//

import Foundation

struct FunFactDomain {
    
    var id: String = UUID().uuidString
    var description: String
    var url: String
    
}

extension FunFactDomain {
        
    static let defaultFunFact = FunFactDomain(
        id: UUID().uuidString,
        description: "Romantic Dinner will increase your wife’s serotonin level which can make her feel happier.",
        url: "https://medium.com/@andytherd/the-7-things-that-make-a-romantic-dinner-according-to-women-9df2ed3a74c5"
    )
    
    
}

