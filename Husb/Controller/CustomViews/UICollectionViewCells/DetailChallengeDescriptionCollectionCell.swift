//
//  DetailChallengeDescriptionCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

class DetailChallengeDescriptionCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailChallengeDescriptionCollectionCell.self)

    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Description"
        label.textColor = .jetBlack
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.text = "Description"
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
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
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom).offset(3)
        }

        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    func fill(with challenge: ChallengeDomain) {
        self.descriptionLabel.text = challenge.description
    }
    
}
