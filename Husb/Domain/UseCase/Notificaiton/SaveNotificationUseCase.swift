//
//  SaveNotificationUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 21/07/21.
//

import Foundation
import CloudKit

struct SaveNotificationUseCaseResponse {
    let notification: NotificationDomain
}

struct SaveNotificationUseCaseRequest {
    let notification: NotificationDomain
}

protocol SaveNotificationUseCase {
    func execute(_ request: SaveNotificationUseCaseRequest,
                 completion: @escaping (Result<SaveNotificationUseCaseResponse, Error>) -> Void)
}

final class DefaultSaveNotificationUseCase {

    let remoteService: RemoteService
    
    init(
        remoteService: RemoteService = RemoteService.shared
    ) {
        self.remoteService = remoteService
    }

}

extension DefaultSaveNotificationUseCase: SaveNotificationUseCase {

    func execute(_ request: SaveNotificationUseCaseRequest, completion: @escaping (Result<SaveNotificationUseCaseResponse, Error>) -> Void) {
        var predicate: NSPredicate
        if let challengeId = request.notification.challengeId {
            predicate = NSPredicate(format: "\(Notification.challengeIdKey) == %@ && \(Notification.notificationTypeKey) == %@", challengeId, request.notification.notificationType.rawValue)
        } else {
            predicate = NSPredicate(format: "\(Notification.idKey) == %@", request.notification.id)
        }
        let query = CKQuery(recordType: .notifications, predicate: predicate)
        DispatchQueue.global(qos: .background).async {
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    var insertedRecord: CKRecord
                    let notification = request.notification.toRemote()
                    if let record = records?.first {
                        insertedRecord = notification.synchronizeRecord(from: record)
                    } else {
                        insertedRecord = notification.toRecord()
                    }
                    self.remoteService.publicDatabase.save(insertedRecord) { records, error in
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(.init(notification: request.notification)))
                        }
                    }
                }
            }
        }
    }
    
}
