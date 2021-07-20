//
//  CompletedChallengeMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 08/07/21.
//

import SwiftMessages
import UIKit


class CompletedChallengeMessageView: MessageView {
    
    var choosePhotoButtonHandler: (()->Void)?
    var skipButtonHandler: (()->Void)?
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulations!"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .jetBlack
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "It's time to upload your moment from the challenge."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        return label
    }()
    lazy var choosePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose a photo", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .seaBlue
        button.dropShadow(
            withColor: .darkGray,
            opacity: 0.5,
            offset: .init(width: 1.5, height: 1.5)
        )
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.onChoosePhotoButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SKIP", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .right
        button.addTarget(self, action: #selector(self.onSkipButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 20
        view.dropShadow(withColor: .spaceGrey, opacity: 0.5, offset: .init(width: 2, height: 2))
        
        view.addSubview(self.customTitleLabel)
        view.addSubview(self.descriptionLabel)
        view.addSubview(self.choosePhotoButton)
        view.addSubview(self.skipButton)

        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(25)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
        self.choosePhotoButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.descriptionLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(48)
            make.bottom.greaterThanOrEqualTo(self.skipButton.snp.top).offset(-15)
        }
        self.skipButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(15)
            make.width.equalTo(50)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(self.mainContentView)
        
        self.mainContentView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.bottom.equalToSuperview()
        }
    }
    
}


extension CompletedChallengeMessageView {
    
    @objc
    private func onChoosePhotoButtonDidTap(_ sender: UIButton) {
        self.choosePhotoButtonHandler?()
    }
    
    @objc
    private func onSkipButtonDidTap(_ sender: UIButton) {
        self.skipButtonHandler?()
    }
    
}
