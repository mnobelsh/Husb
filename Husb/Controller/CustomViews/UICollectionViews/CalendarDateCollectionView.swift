//
//  CalendarDateCollectionView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 09/07/21.
//

import UIKit

class CalendarDateCollectionView: UICollectionView {

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumLineSpacing = 10
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = true
        self.register(
            CalendarDateCollectionCell.self,
            forCellWithReuseIdentifier: CalendarDateCollectionCell.identifier
        )
        self.register(
            EmptyCollectionViewCell.self,
            forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier
        )
        self.contentInset = .init(top: 0, left: 25, bottom: 0, right: 25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

