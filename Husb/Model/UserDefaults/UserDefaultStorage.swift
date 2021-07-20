//
//  UserDefaultStorage.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import Foundation

class UserDefaultStorage {

    static let shared = UserDefaultStorage()
    
    enum UserDefaultKey: String {
        case userOnboardingState = "userOnboardingState"
        case currentUserId = "currentUserId"
    }
    
    func setValue(_ value: Any?, forKey key: UserDefaultKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    func getValue(forKey key: UserDefaultKey) -> Any? {
        UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    
}
