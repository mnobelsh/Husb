//
//  DetailChallengeCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/06/21.
//

import UIKit

class DetailChallengeCollectionView: UICollectionView {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case action = 1
        case description = 2
        case steps = 3
        case funFacts = 4
    }
    

    init(frame: CGRect) {
        super.init(
            frame: frame,
            collectionViewLayout: DetailChallengeCollectionView.makeCompositionalLayout()
        )
        self.register(
            DetailChallengeActionCollectionCell.self,
            forCellWithReuseIdentifier: DetailChallengeActionCollectionCell.identifier
        )
        self.register(
            DetailChallengeCollectionHeaderView.self,
            forCellWithReuseIdentifier: DetailChallengeCollectionHeaderView.identifier
        )
        self.register(
            DetailChallengeDescriptionCollectionCell.self,
            forCellWithReuseIdentifier: DetailChallengeDescriptionCollectionCell.identifier
        )
        self.register(
            DetailChallengeStepCollectionCell.self,
            forCellWithReuseIdentifier: DetailChallengeStepCollectionCell.identifier
        )
        self.register(
            DetailChallengeFunFactCollectionCell.self,
            forCellWithReuseIdentifier: DetailChallengeFunFactCollectionCell.identifier
        )
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .clear
        self.contentInset = .init(top: 0, left: 0, bottom: 25, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DetailChallengeCollectionView {
    
    static func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env in
            
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
            
            switch section {
                case .header:
                    layoutItem.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 0)
                    groupSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(230)
                    )
                    layoutGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [layoutItem]
                    )
                            
                    layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                    layoutSection.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 0)
                case .action:
                    groupSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.2)
                    )
                    layoutGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [layoutItem]
                    )
                            
                    layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                    layoutSection.contentInsets = .init(top: 5, leading: 15, bottom: 5, trailing: 15)
                case .description:
                    groupSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.35)
                    )
                    layoutGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [layoutItem]
                    )
                            
                    layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                    layoutSection.contentInsets = .init(top: 5, leading: 15, bottom: 5, trailing: 15)
                case .steps:
                    groupSize = .init(
                        widthDimension: .fractionalWidth(0.6),
                        heightDimension: .fractionalHeight(0.3)
                    )
                    layoutGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [layoutItem]
                    )
                            
                    layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                    layoutSection.contentInsets = .init(top: 5, leading: 15, bottom: 5, trailing: 15)
                    layoutSection.orthogonalScrollingBehavior = .continuous
                case .funFacts:
                    groupSize = .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.7)
                    )
                    layoutGroup = NSCollectionLayoutGroup.horizontal(
                        layoutSize: groupSize,
                        subitems: [layoutItem]
                    )
                            
                    layoutSection = NSCollectionLayoutSection(group: layoutGroup)
                    layoutSection.contentInsets = .init(top: 5, leading: 15, bottom: 5, trailing: 15)
            case .none:
                break
            }
            

            
            return layoutSection
            
        }
    }
    
}
