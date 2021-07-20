//
//  DetailChallengeActionCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/06/21.
//

import UIKit

protocol DetailChallengeActionCollectionCellDelegate: AnyObject {
    
    func detailChallengeActionCollectionCell(
        _ cell: DetailChallengeActionCollectionCell,
        didTap joinChallengeButton: UIButton
    )
    
}

class DetailChallengeActionCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: DetailChallengeActionCollectionCell.self)
    
    private var user: UserDomain?
    private var challenge: ChallengeDomain!
    
    weak var delegate: DetailChallengeActionCollectionCellDelegate?
    
    private var categories: [String] = []
    
    // MARK: - SubViews
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "TAGS:"
        label.textColor = .jetBlack
        return label
    }()
    private lazy var tagsCollectionView: ChallengeCategoryCollectionView = {
        let collectionView = ChallengeCategoryCollectionView(frame: self.frame)
        collectionView.dataSource = self
        return collectionView
    }()
    private lazy var joinChallengeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Join Challenge", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.6
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .seaBlue
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = .init(width: 1.5, height: 1.5)
        button.layer.shadowOpacity = 0.5
        button.addTarget(self, action: #selector(self.onJoinChallengeButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.contentView.addSubview(self.tagsLabel)
        self.contentView.addSubview(self.tagsCollectionView)
        self.contentView.addSubview(self.joinChallengeButton)
        self.tagsLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        self.tagsCollectionView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(self.frame.width/2)
            make.top.equalTo(self.tagsLabel.snp.bottom).offset(15)
        }
        self.joinChallengeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.tagsLabel.snp.top)
            make.leading.equalTo(self.tagsCollectionView.snp.trailing).offset(5)
        }
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    func fill(with challenge: ChallengeDomain) {
        self.challenge = challenge
        self.categories = [challenge.loveLanguage.title,challenge.role.title]
        self.tagsCollectionView.reloadData()
        self.joinChallengeButton.isEnabled = !challenge.isActive
        if challenge.isActive {
            self.joinChallengeButton.backgroundColor = .pearlWhite
            guard let challengeDueDate = challenge.dueDate else { return }
            self.joinChallengeButton.setTitle(challengeDueDate.getString(withFormat: "EEEE,d MMMM YYYY"), for: .normal)
            self.joinChallengeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        } else {
            self.joinChallengeButton.backgroundColor = .seaBlue
            self.joinChallengeButton.setTitle("Join Challenge", for: .normal)
        }
        if challenge.isCompleted {
            self.joinChallengeButton.isEnabled = false
            self.joinChallengeButton.backgroundColor = .funYellow
            self.joinChallengeButton.setTitle("Completed", for: .normal)
            self.joinChallengeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        }
    }
    
}

// MARK: - @objc Function
extension DetailChallengeActionCollectionCell {
    
    @objc
    private func onJoinChallengeButtonDidTap(_ sender: UIButton) {
        self.delegate?.detailChallengeActionCollectionCell(self, didTap: sender)
    }
    
}


// MARK: - DetailChallengeCollectionCell+UICollectionViewDataSource
extension DetailChallengeActionCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCategoryCollectionCell.identifier, for: indexPath) as? ChallengeCategoryCollectionCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.fill(loveLanguage: self.challenge.loveLanguage)
        } else if indexPath.row == 1 {
            cell.fill(role: self.challenge.role)
        }
        return cell
    }
    
    
}
