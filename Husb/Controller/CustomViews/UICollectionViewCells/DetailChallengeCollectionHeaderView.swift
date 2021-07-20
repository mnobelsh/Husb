//
//  DetailChallengeCollectionHeaderView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 21/06/21.
//

import UIKit

protocol DetailChallengeCollectionHeaderViewDelegate: AnyObject {
    func detailChallengeCollectionHeaderView(_ view: UICollectionViewCell, didTapSaveButton button: UIButton)
}

class DetailChallengeCollectionHeaderView: UICollectionViewCell {
    
    static let identifier: String = String(describing: DetailChallengeCollectionHeaderView.self)
    
    weak var delegate: DetailChallengeCollectionHeaderViewDelegate?
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .jetBlack
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.text = "Challenge Title"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .left
        return label
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage.bookmarkIcon.withTintColor(.funYellow, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(
            self,
            action: #selector(self.onSaveButtonTouchUpInside(_:)),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var saveButtonContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .seaBlue
        view.snp.makeConstraints { make in
            make.width.height.equalTo(45)
        }
        view.layer.cornerRadius = 45/2
        view.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        return view
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Functions
    private func setupUI() {
        self.backgroundColor = .pearlWhite
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.saveButtonContainerView)
        self.contentView.addSubview(self.imageView)
        
        self.saveButtonContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(self.frame.width*0.45)
        }
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.top)
            make.trailing.equalTo(self.saveButtonContainerView.snp.leading).offset(-20)
            make.leading.equalTo(self.titleLabel.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        
        self.layer.shadowColor = UIColor.spaceGrey.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .init(width: 0, height: 3.5)
        self.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
       
    
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
    
    @objc
    private func onSaveButtonTouchUpInside(_ sender: UIButton) {
        self.delegate?.detailChallengeCollectionHeaderView(self, didTapSaveButton: self.saveButton)
    }
    
    
    func fill(challenge: ChallengeDomain) {
        self.titleLabel.text = challenge.title
        self.imageView.image = challenge.posterImage
        if !challenge.isActive && challenge.addedDate == nil {
            self.saveButton.setBackgroundImage(UIImage.bookmarkIcon.withTintColor(.pearlWhite, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            self.saveButton.setBackgroundImage(UIImage.bookmarkIcon.withTintColor(.funYellow, renderingMode: .alwaysOriginal), for: .normal)
        }
    }
    
}
