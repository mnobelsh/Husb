//
//  CompletedChallengeCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit

class CompletedChallengeCollectionCell: UICollectionViewCell {

    static let identifier: String = String(describing: CompletedChallengeCollectionCell.self)
    
    private var challenge: ChallengeDomain?
    private var categories = [String]()
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Challenge Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.isSkeletonable = true
        return label
    }()
    lazy var categoryCollectionView: ChallengeCategoryCollectionView = ChallengeCategoryCollectionView(frame: self.bounds)
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Challenge Title"
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .onboardingConnect)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
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
        self.backgroundColor = .pearlWhite
        self.dropShadow()
        self.layer.cornerRadius = 15
        
        self.categoryCollectionView.dataSource = self
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.categoryCollectionView)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.bottom.equalToSuperview().offset(-15)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(self.imageView.snp.leading).offset(-10)
            make.height.equalTo(50)
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(self.imageView.snp.leading).offset(-10)
            make.height.equalTo(25)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.categoryCollectionView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(self.imageView.snp.leading).offset(-20)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        self.titleLabel.isHidden = false
        self.imageView.isHidden = false
        self.categoryCollectionView.isHidden = false
    }
    
    func fill(challenge: ChallengeDomain) {
        self.challenge = challenge
        self.categories = [challenge.loveLanguage.title,challenge.role.title]
        self.titleLabel.text = challenge.title
        self.imageView.image = challenge.momentImage ?? .onboardingConnect
        self.descriptionLabel.text = challenge.description.components(separatedBy: .whitespaces).prefix(25).joined(separator: " ") + "..."
        self.categoryCollectionView.reloadData()
    }
    
    func fill(title: String, description: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.imageView.image = .onboardingConnect
        self.categoryCollectionView.isHidden = true
    }
}

extension CompletedChallengeCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCategoryCollectionCell.identifier, for: indexPath) as? ChallengeCategoryCollectionCell else { return UICollectionViewCell() }
        guard let challenge = self.challenge else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.fill(loveLanguage: challenge.loveLanguage)
        } else if indexPath.row == 1 {
            cell.fill(role: challenge.role)
        }
        return cell
    }
    
}
