//
//  DefaultChallengeCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 13/06/21.
//

import UIKit

class DefaultChallengeCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: DefaultChallengeCollectionCell.self)
    
    private var challenge: ChallengeDomain?
    private var categories: [String] = []
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .jetBlack
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.lastLineFillPercent = 50
        label.linesCornerRadius = 5
        return label
    }()
    private lazy var categoryCollectionView: ChallengeCategoryCollectionView = {
        let collectionView = ChallengeCategoryCollectionView(frame: self.frame)
        collectionView.dataSource = self
        collectionView.isSkeletonable = true
        return collectionView
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
        imageView.skeletonCornerRadius = 10
        return imageView
    }()
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        
        view.addSubview(self.imageView)
        view.addSubview(self.categoryCollectionView)
        view.addSubview(self.titleLabel)
        
        self.imageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(self.titleLabel.snp.top).offset(-15)
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview().inset(10)
            make.height.equalTo(25)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(self.categoryCollectionView.snp.top).offset(-5)
        }
        
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.spaceGrey.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .init(width: 0.5, height: 0.5)
        
        view.setNeedsLayout()
        view.layoutIfNeeded()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.mainContainerView)
        
        self.mainContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.backgroundColor = .clear
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    
    func fill(challenge: ChallengeDomain) {
        self.challenge = challenge
        self.categories = [challenge.loveLanguage.title,challenge.role.title]
        self.titleLabel.text = challenge.title
        self.imageView.image = challenge.posterImage
        self.categoryCollectionView.reloadData()
    }
    
    func fill(title: String, image: UIImage?) {
        self.titleLabel.text = title
        self.imageView.image = image
    }
    
    
}


extension DefaultChallengeCollectionCell: UICollectionViewDataSource {
    
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
