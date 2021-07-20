//
//  UncompletedChallengeCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit

protocol UncompletedChallengeCollectionCellDelegate: AnyObject {
    func uncompletedChallengeCollectionCell(_ cell: UncompletedChallengeCollectionCell, didTap goToChallengeButton: UIButton, challenge: ChallengeDomain)
}

class UncompletedChallengeCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: UncompletedChallengeCollectionCell.self)
    
    private var challenge: ChallengeDomain?
    private var categories: [String] = []
    
    weak var delegate: UncompletedChallengeCollectionCellDelegate?
    
    // MARK: - SubViews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Challenge Title"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.numberOfLines = 0
        return label
    }()
    lazy var categoryCollectionView: ChallengeCategoryCollectionView = ChallengeCategoryCollectionView(frame: self.bounds)
    lazy var goToChallengeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go To Challenge", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.jetBlack, for: .normal)
        button.layer.cornerRadius = 15
        button.backgroundColor = .skyBlue
        button.addTarget(
            self,
            action: #selector(self.onGoToChallengeButtonDidTap(_:)),
            for: .touchUpInside
        )
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
        self.backgroundColor = .pearlWhite
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.heartRed.cgColor
        self.layer.cornerRadius = 15
        
        self.categoryCollectionView.dataSource = self
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.categoryCollectionView)
        self.contentView.addSubview(self.goToChallengeButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        self.categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(25)
        }
        
        self.goToChallengeButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.categoryCollectionView).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        self.titleLabel.isHidden = false
        self.categoryCollectionView.isHidden = false
        self.goToChallengeButton.isHidden = false
        self.titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(35)
        }
        
        self.categoryCollectionView.snp.remakeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(25)
        }
        
        self.goToChallengeButton.snp.remakeConstraints { make in
            make.top.greaterThanOrEqualTo(self.categoryCollectionView).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(48)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    func fill(challenge: ChallengeDomain) {
        self.challenge = challenge
        self.categories = [challenge.loveLanguage.title,challenge.role.title]
        self.titleLabel.text = challenge.title
        self.categoryCollectionView.reloadData()
    }
    
    func fill(title: String, buttonIsHidden: Bool) {
        self.titleLabel.text = title
        self.goToChallengeButton.isHidden = buttonIsHidden
        self.titleLabel.snp.remakeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
            make.trailing.bottom.equalToSuperview().offset(-20)
        }
        self.categoryCollectionView.isHidden = true
    }
    
    @objc
    private func onGoToChallengeButtonDidTap(_ sender: UIButton) {
        guard let challenge = self.challenge else { return }
        self.delegate?.uncompletedChallengeCollectionCell(self, didTap: sender, challenge: challenge)
    }
    
}

extension UncompletedChallengeCollectionCell: UICollectionViewDataSource {
    
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
