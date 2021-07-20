//
//  DashboardNotificationCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit

class DashboardNotificationCollectionView: UICollectionView {

    enum Section: Int, CaseIterable {
        case header = 0
        case notification = 1
    }

    init(frame: CGRect) {
        super.init(
            frame: frame,
            collectionViewLayout: DashboardNotificationCollectionView.makeCompositionalLayout()
        )
        self.register(
            NotificationCollectionHeaderView.self,
            forCellWithReuseIdentifier: NotificationCollectionHeaderView.identifier
        )
        self.register(
            NotificationCollectionCell.self,
            forCellWithReuseIdentifier: NotificationCollectionCell.identifier
        )
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    private func setupUI() {
        self.backgroundColor = .ghostWhite
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.contentInsetAdjustmentBehavior = .never
    }
    
}

extension DashboardNotificationCollectionView {
    
    static func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            
            let item: NSCollectionLayoutItem = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            var groupSize: NSCollectionLayoutSize!
            var layoutSection: NSCollectionLayoutSection!
            let section = Section(rawValue: sectionIndex)
            switch section {
            case .header:
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(230)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = .init(group: group)
                layoutSection.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                return layoutSection
            case .notification:
                item.contentInsets = .init(top: 0, leading: 15, bottom: 4, trailing: 15)
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(65)
                )
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                layoutSection = .init(group: group)
                layoutSection.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
                return layoutSection
            case .none:
                break
            }
            
            return layoutSection
        }
    }
    
}
