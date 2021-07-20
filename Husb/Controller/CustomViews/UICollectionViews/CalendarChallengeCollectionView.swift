//
//  CalendarChallengeCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit

class CalendarChallengeCollectionView: UICollectionView {
    
    enum Section: Int, CaseIterable {
        case uncompleted = 0
        case completed = 1
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: CalendarChallengeCollectionView.makeCompositionalLayout())
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.contentInset = .init(top: 25, left: 0, bottom: 25, right: 0)
        self.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: SectionHeaderView.kind,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        self.register(
            CompletedChallengeCollectionCell.self,
            forCellWithReuseIdentifier: CompletedChallengeCollectionCell.identifier
        )
        self.register(
            UncompletedChallengeCollectionCell.self,
            forCellWithReuseIdentifier: UncompletedChallengeCollectionCell.identifier
        )
        self.register(
            EmptyCollectionViewCell.self,
            forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier
        )
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .spaceGrey
    }
    
}

extension CalendarChallengeCollectionView {
    
    static func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            let layoutItem = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1))
            )
            layoutItem.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
            var groupSize: NSCollectionLayoutSize!
            var layoutGroup: NSCollectionLayoutGroup!
            var layoutSection: NSCollectionLayoutSection!
            var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem!
            
            switch Section(rawValue: sectionIndex) {
            case .uncompleted:
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalWidth(0.45)
                )
                layoutGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [layoutItem]
                )
                        
                layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.contentInsets = .init(top: 10, leading: 15, bottom: 25, trailing: 15)
                
                sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(25)
                    ),
                    elementKind: elementKindSectionHeader,
                    alignment: .topLeading
                )
                layoutSection.boundarySupplementaryItems = [sectionHeader]
                layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            case .completed:
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.6)
                )
                layoutGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [layoutItem]
                )
                        
                layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                layoutSection.contentInsets = .init(top: 10, leading: 15, bottom: 25, trailing: 15)
                
                sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(25)
                    ),
                    elementKind: elementKindSectionHeader,
                    alignment: .topLeading
                )
                layoutSection.boundarySupplementaryItems = [sectionHeader]
            case .none:
                break
            }
            return layoutSection
        }
    }
    
}
