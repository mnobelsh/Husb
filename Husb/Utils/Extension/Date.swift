//
//  Date.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 08/07/21.
//

import Foundation

extension Date {
    
    func getString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
