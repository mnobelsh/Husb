//
//  WifeMoodCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

class WifeMoodCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: WifeMoodCollectionCell.self)
    
    // MARK: - SubViews
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .darkGray
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.isSkeletonable = true
        label.lastLineFillPercent = 50
        label.linesCornerRadius = 5
        return label
    }()
    private lazy var moodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 10
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
        self.contentView.addSubview(self.moodImageView)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.moodImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-25)
            make.width.equalTo(self.moodImageView.snp.height)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(20)
            make.trailing.equalTo(self.moodImageView.snp.leading).offset(-20)
        }
    
        self.layer.cornerRadius = 10
        self.backgroundColor = .pearlWhite
        
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.funYellow.cgColor
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    
    func fill(mood: MoodDomain, role: RoleDomain.RoleType) {
        self.descriptionLabel.text = mood.description
        switch mood.type {
        case .happy:
            self.moodImageView.image = .moodHappy
        case .sad:
            self.moodImageView.image = .moodSad
        case .angry:
            self.moodImageView.image = .moodAngry
        case .worried:
            self.moodImageView.image = .moodWorried
        case .tired:
            self.moodImageView.image = .moodTired
        case .excited:
            self.moodImageView.image = .moodExcited
        }
        switch role {
        case .wife:
            self.descriptionLabel.text = "You're feeling \(mood.title), Tap to update your current feelings with your husband."
            break
        default:
            break
        }
    }
    
    func fill(description: String) {
        self.descriptionLabel.text = description
    }
    
}
