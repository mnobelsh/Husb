//
//  DashboardChallengeCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit


class DashboardChallengeCollectionView: UICollectionView {
    
    enum Section: Int, CaseIterable {
        case currentChallenge = 0
        case simpleThings = 1
        case mood = 2
        case savedChallenge = 3
        case tips = 4
    }
    
    init(frame: CGRect) {
        super.init(
            frame: frame,
            collectionViewLayout: DashboardChallengeCollectionView.makeCompositionalLayout()
        )
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    private func setupCollectionView() {
        self.register(
            CurrentChallengeCollectionCell.self,
            forCellWithReuseIdentifier: CurrentChallengeCollectionCell.identifier
        )
        self.register(
            SimpleThingsCollectionCell.self,
            forCellWithReuseIdentifier: SimpleThingsCollectionCell.identifier
        )
        self.register(
            WifeMoodCollectionCell.self,
            forCellWithReuseIdentifier: WifeMoodCollectionCell.identifier
        )
        self.register(
            DefaultChallengeCollectionCell.self,
            forCellWithReuseIdentifier: DefaultChallengeCollectionCell.identifier
        )
        self.register(
            TipsCollectionCell.self,
            forCellWithReuseIdentifier: TipsCollectionCell.identifier
        )
        self.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: SectionHeaderView.kind,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .spaceGrey
        self.backgroundColor = .clear
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.contentInset = .init(top: 25, left: 0, bottom: 25, right: 0)
    }
    
    
}


fileprivate extension DashboardChallengeCollectionView {
    
    static func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex, env) -> NSCollectionLayoutSection? in
            
            let section = Section(rawValue: sectionIndex)
            
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
            
            switch section {
            case .currentChallenge:
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .fractionalWidth(0.6)
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
            case .simpleThings:
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.45),
                    heightDimension: .fractionalWidth(0.55)
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
                layoutSection.orthogonalScrollingBehavior = .continuous
            case .mood:
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.36)
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
            case .savedChallenge:
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.75),
                    heightDimension: .fractionalWidth(0.5)
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
            case .tips:
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.55)
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
            case .none:
                break
            }
            
            
            return layoutSection
        }
        
    }
    
}
