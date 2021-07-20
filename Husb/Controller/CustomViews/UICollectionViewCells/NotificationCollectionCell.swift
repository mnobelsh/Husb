//
//  NotificationCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

class NotificationCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: NotificationCollectionCell.self)
    
    lazy var messageIconView: UIImageView = {
        let imageView = UIImageView(image: .messageBlue)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.numberOfLines = 1
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .spaceGrey
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.contentView.addSubview(self.messageIconView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.messageIconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(self.messageIconView.snp.height)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.messageIconView)
            make.leading.equalTo(self.messageIconView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.leading.equalTo(self.messageIconView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.messageIconView)
        }
        self.backgroundColor = .pearlWhite
        self.dropShadow()
        self.layer.cornerRadius = 10
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    func fill(with notification: NotificationDomain) {
        switch notification.notificationType {
        case .challengeRequest:
            self.titleLabel.text = notification.challenge?.title
            self.descriptionLabel.text = notification.challenge?.description
            self.messageIconView.image = .messageYellow
            self.messageIconView.heroID = "ChallengeRequestHero"
        case .message:
            self.titleLabel.text = notification.message?.title
            self.descriptionLabel.text = notification.message?.message
            self.messageIconView.image = .messageBlue
            self.messageIconView.heroID = "MessageFromWifeHero"
        }
    }
}
