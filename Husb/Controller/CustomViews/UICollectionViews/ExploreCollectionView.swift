//
//  ExploreCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 14/06/21.
//

import UIKit

class ExploreCollectionView: UICollectionView {
    
    enum Section: Int, CaseIterable {
        case header = 0
        case loveLanguage = 1
        case mostSaved = 2
        case forYouAndSoulmate = 3
        case hubbyChallenges = 4
    }

    init(frame: CGRect) {
        super.init(frame: frame, collectionViewLayout: ExploreCollectionView.makeCompositionalLayout())
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    private func setupUI() {
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .clear
        self.register(
            ExploreCollectionHeaderView.self,
            forCellWithReuseIdentifier: ExploreCollectionHeaderView.identifier
        )
        self.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: SectionHeaderView.kind,
            withReuseIdentifier: SectionHeaderView.identifier
        )
        self.register(
            LoveLanguageCollectionCell.self,
            forCellWithReuseIdentifier: LoveLanguageCollectionCell.identifier
        )
        self.register(
            DefaultChallengeCollectionCell.self,
            forCellWithReuseIdentifier: DefaultChallengeCollectionCell.identifier
        )
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = .spaceGrey
    }
    
}

// MARK: - Static Function
extension ExploreCollectionView {
    
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
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(25)
                ),
                elementKind: elementKindSectionHeader,
                alignment: .topLeading
            )
            
            let section = Section(rawValue: sectionIndex)
            switch section {
            case .header:
                groupSize = .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(230)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = .init(group: group)
                layoutSection.contentInsets = .init(top: 0, leading: 0, bottom: 25, trailing: 0)
                return layoutSection
            case .loveLanguage:
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .fractionalWidth(0.45)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = .init(group: group)
                layoutSection.boundarySupplementaryItems = [sectionHeader]
                layoutSection.contentInsets = .init(top: 10, leading: 15, bottom: 25, trailing: 15)
                layoutSection.orthogonalScrollingBehavior = .continuous
                return layoutSection
            case .mostSaved,.forYouAndSoulmate,.hubbyChallenges:
                item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
                groupSize = .init(
                    widthDimension: .fractionalWidth(0.75),
                    heightDimension: .fractionalWidth(0.5)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                layoutSection = .init(group: group)
                layoutSection.boundarySupplementaryItems = [sectionHeader]
                layoutSection.contentInsets = .init(top: 0, leading: 15, bottom: 25, trailing: 15)
                layoutSection.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                return layoutSection
            case .none:
                break
            }
            

            return layoutSection
        }
    }
    
}
