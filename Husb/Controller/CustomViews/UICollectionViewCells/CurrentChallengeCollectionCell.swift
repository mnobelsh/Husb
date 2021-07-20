//
//  CurrentChallengeCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit
import SnapKit

class CurrentChallengeCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: CurrentChallengeCollectionCell.self)
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .jetBlack
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 2
        label.isSkeletonable = true
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.isSkeletonable = true
        return label
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.imageView)
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.descriptionLabel.snp.top).offset(-5)
        }
        self.imageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-20)
        }
        
        self.layer.cornerRadius = 10
        self.backgroundColor = .pearlWhite
        
        self.layer.shadowColor = UIColor.spaceGrey.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    
    func fill(challenge: ChallengeDomain) {
        self.titleLabel.text = challenge.title
        self.descriptionLabel.text = challenge.description
        self.imageView.image = challenge.posterImage
    }

    
}
