//
//  FetchNotificationsUseCase.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 21/07/21.
//

import Foundation
import CloudKit

struct FetchNotificationsUseCaseResponse {
    let notifications: [NotificationDomain]
}

struct FetchNotificationsUseCaseRquest {
    let userId: String
}

protocol FetchNotificationsUseCase {
    func execute(_ request: FetchNotificationsUseCaseRquest,
                 completion: @escaping (Result<FetchNotificationsUseCaseResponse, Error>) -> Void)
}

final class DefaultFetchNotificationsUseCase {

    let remoteService: RemoteService
    
    init(
        remoteService: RemoteService = RemoteService.shared
    ) {
        self.remoteService = remoteService
    }

}

extension DefaultFetchNotificationsUseCase: FetchNotificationsUseCase {

    func execute(_ request: FetchNotificationsUseCaseRquest, completion: @escaping (Result<FetchNotificationsUseCaseResponse, Error>) -> Void) {
        let predicate = NSPredicate(format: "receiverId == %@", request.userId)
        let query = CKQuery(recordType: .notifications, predicate: predicate)
        DispatchQueue.global(qos: .background).async {
            self.remoteService.publicDatabase.perform(query, inZoneWith: nil) { records, error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let notificationRecords = records {
                        let notifications = notificationRecords.map({ Notification().getNotification(from: $0).toDomain() })
                        completion(.success(.init(notifications: notifications)))
                    } else {
                        completion(.success(.init(notifications: [])))
                    }
                }
            }
        }
    }
    
}
