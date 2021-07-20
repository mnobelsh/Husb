//
//  NotificationCollectionHeaderView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit

class NotificationCollectionHeaderView: UICollectionViewCell {
    
    static let identifier: String = String(describing: NotificationCollectionHeaderView.self)
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        
        let mutableAttributedTitle = NSMutableAttributedString(
            string: "Notifications\n",
            attributes: [
                .foregroundColor: UIColor.jetBlack,
                .font: UIFont.boldSystemFont(ofSize: 28)
            ]
        )
        let descriptionAttributedTitle = NSAttributedString(
            string: "\nThese are custom challenges and challenge completion alerts from your husband",
            attributes: [
                .foregroundColor: UIColor.jetBlack,
                .font: UIFont.systemFont(ofSize: 16)
            ]
        )
        mutableAttributedTitle.append(descriptionAttributedTitle)
        label.attributedText = mutableAttributedTitle
        
        return label
    }()
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        view.backgroundColor = .skyBlue
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Functions
private extension NotificationCollectionHeaderView {
    
    func setupUI() {
        self.contentView.addSubview(self.mainContainerView)
        self.mainContainerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        self.backgroundColor = .clear
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}


