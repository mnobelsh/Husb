//
//  ChallengeCategoryCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

class ChallengeCategoryCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Function
    private func setupCollectionView() {
        self.register(
            ChallengeCategoryCollectionCell.self,
            forCellWithReuseIdentifier: ChallengeCategoryCollectionCell.identifier
        )
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.isScrollEnabled = false
    }
}
