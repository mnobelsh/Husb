//
//  Array.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/07/21.
//

import Foundation

extension Array where Element: Equatable {
    
    func indexOf(_ element: Element) -> Int? {
        for index in 0..<self.count {
            if self[index] == element {
                return index
            }
        }
        return nil
    }
    
    
}

extension Array where Element == ChallengeDomain {
    
    enum SortParameter {
        case dueDate
        case title
        case addedDate
    }
    
    enum Order {
        case ascending
        case descending
    }
    
    func sortBy(_ sortParameter: SortParameter, order: Order) -> [ChallengeDomain] {
        return self.sorted { challenge1, challenge2 in
            switch sortParameter {
            case .addedDate:
                guard let challenge1AddedDate = challenge1.addedDate, let challenge2AddedDate = challenge2.addedDate else {
                    return true
                }
                switch order {
                case .ascending:
                    return challenge1AddedDate.compare(challenge2AddedDate) == .orderedAscending
                case .descending:
                    return challenge1AddedDate.compare(challenge2AddedDate) == .orderedDescending
                }
            case .dueDate:
                guard let challenge1DueDate = challenge1.dueDate, let challenge2DueDate = challenge2.dueDate else {
                    return true
                }
                switch order {
                case .ascending:
                    return challenge1DueDate.compare(challenge2DueDate) == .orderedAscending
                case .descending:
                    return challenge1DueDate.compare(challenge2DueDate) == .orderedDescending
                }
            case .title:
                switch order {
                case .ascending:
                    return challenge1.title.compare(challenge2.title) == .orderedAscending
                case .descending:
                    return challenge1.title.compare(challenge2.title) == .orderedDescending
                }
            }
        }
    }
    
    
}
