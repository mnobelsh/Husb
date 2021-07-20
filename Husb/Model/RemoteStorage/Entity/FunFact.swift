//
//  FunFact.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import Foundation
import CloudKit

final class FunFact {
    
    static let idKey = "id"
    static let descriptionKey = "description"
    static let urlKey = "url"
    static let challengeKey = "challenge"
    
    var id: String = UUID().uuidString
    var description: String = ""
    var url: String = ""
    
}

extension FunFact {
    
    func toDomain() -> FunFactDomain {
        return FunFactDomain(id: self.id, description: self.description, url: self.url)
    }
    
    @discardableResult
    func synchronizeRecord(from record: CKRecord) -> CKRecord {
        record.setValue(self.description, forKey: FunFact.descriptionKey)
        record.setValue(self.url, forKey: FunFact.urlKey)
        return record
    }
    
    @discardableResult
    func toRecord() -> CKRecord {
        let record = CKRecord(recordType: .funFact)
        record.setValue(self.id, forKey: FunFact.idKey)
        record.setValue(self.description, forKey: FunFact.descriptionKey)
        record.setValue(self.url, forKey: FunFact.urlKey)
        return record
    }
    
    @discardableResult
    func getFunFact(from record: CKRecord) -> FunFact {
        let funFact = FunFact()
        funFact.id = record.value(forKey: FunFact.idKey) as? String ?? ""
        funFact.description = record.value(forKey: FunFact.descriptionKey) as? String ?? ""
        funFact.url = record.value(forKey: FunFact.urlKey) as? String ?? ""
        return funFact
    }
    
}


extension FunFactDomain {
    
    func toRemote() -> FunFact {
        let funcFact = FunFact()
        funcFact.id = self.id
        funcFact.description = self.description
        funcFact.url = self.url
        return funcFact
    }
    
}
