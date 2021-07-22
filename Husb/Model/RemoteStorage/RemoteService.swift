//
//  RemoteService.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import Foundation
import CloudKit


class RemoteService {
    
    static let shared = RemoteService()
    static let identifier: String = "iCloud.Husb-Thesis"
    
    let privateDatabase = CKContainer(identifier: RemoteService.identifier).privateCloudDatabase
    let sharedDatabase = CKContainer(identifier: RemoteService.identifier).sharedCloudDatabase
    let publicDatabase = CKContainer(identifier: RemoteService.identifier).publicCloudDatabase
    
}

extension CKRecord.RecordType {
    
    static let profiles = "Profiles"
    static let challenges = "Challenges"
    static let challengeSteps = "ChallengeSteps"
    static let funFact = "FunFacts"
    static let notifications = "Notifications"
    
}
