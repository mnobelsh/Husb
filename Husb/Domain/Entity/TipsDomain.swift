//
//  TipsDomain.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import Foundation

struct TipsDomain {
    
    var id: String = UUID().uuidString
    var title: String
    var description: String
    
}

extension TipsDomain {
    
    static let tipsList: [TipsDomain] = [
        .init(title: "Tips 1", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        .init(title: "Tips 2", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        .init(title: "Tips 3", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        .init(title: "Tips 4", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
        .init(title: "Tips 5", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."),
    ]
    
}
