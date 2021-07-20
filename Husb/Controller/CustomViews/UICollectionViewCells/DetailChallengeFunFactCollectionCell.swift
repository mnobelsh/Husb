//
//  DetailChallengeFunFactCollectionCell.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

protocol DetailChallengeFunFactCollectionCellDelegate: AnyObject {
    
    func detailChallengeFunFactCollectionCell(
        _ cell: DetailChallengeFunFactCollectionCell,
        didTap resourceLinkButton: UIButton
    )
    
}


class DetailChallengeFunFactCollectionCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: DetailChallengeFunFactCollectionCell.self)
    
    weak var delegate: DetailChallengeFunFactCollectionCellDelegate?
    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Fun Fact"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .jetBlack
        label.textAlignment = .center
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    private lazy var resourceLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(
            self,
            action: #selector(self.onResourceLinkButtonDidTap(_:)),
            for: .touchUpInside
        )
        button.setTitle("Check it out!", for: .normal)
        button.setTitleColor(.jetBlack, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .funYellow
        button.layer.cornerRadius = 15
        button.dropShadow()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with funcFact: FunFactDomain) {
        self.descriptionLabel.text = funcFact.description
    }
    
}

// MARK: - Private Functions
private extension DetailChallengeFunFactCollectionCell {
    
    func setupUI() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor.funYellow.cgColor
        self.layer.cornerRadius = 15
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.resourceLinkButton)
        self.contentView.addSubview(self.descriptionLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.resourceLinkButton)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(self.resourceLinkButton.snp.top).offset(-20)
        }
        self.resourceLinkButton.snp.makeConstraints { make in
            make.leading.trailing.greaterThanOrEqualToSuperview().inset(50)
            make.height.equalTo(45)
            make.width.equalTo(75)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
}

// MARK: - @objc Functions
extension DetailChallengeFunFactCollectionCell {
    
    @objc
    private func onResourceLinkButtonDidTap(_ sender: UIButton) {
        self.delegate?.detailChallengeFunFactCollectionCell(self, didTap: sender)
    }
    
}
