//
//  EmptyCollectionViewCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 18/07/21.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: EmptyCollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .pearlWhite
        self.layer.cornerRadius = 15
        self.dropShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
