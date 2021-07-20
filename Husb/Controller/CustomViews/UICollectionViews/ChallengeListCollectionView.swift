//
//  ChallengeListCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 03/07/21.
//

import UIKit

class ChallengeListCollectionView: UICollectionView {

    init(frame: CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: flowLayout)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    private func setupUI() {
        self.contentInsetAdjustmentBehavior = .never
        self.backgroundColor = .ghostWhite
        self.register(
            DefaultChallengeCollectionCell.self,
            forCellWithReuseIdentifier: DefaultChallengeCollectionCell.identifier
        )
        self.register(
            TipsCollectionCell.self,
            forCellWithReuseIdentifier: TipsCollectionCell.identifier
        )
        self.contentInset = .init(top: 20, left: 20, bottom: 35, right: 20)
    }
    
}

extension ChallengeListCollectionView {

    
}
