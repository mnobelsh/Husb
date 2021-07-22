//
//  MoodCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 21/07/21.
//

import UIKit

class MoodCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: MoodCollectionCell.self)
    
    lazy var moodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .jetBlack
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.moodImageView)
        self.contentView.addSubview(self.titleLabel)
        self.moodImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(self.titleLabel.snp.top)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with mood: MoodDomain) {
        self.moodImageView.image = mood.icon
        self.titleLabel.text = mood.title
    }
    
}
