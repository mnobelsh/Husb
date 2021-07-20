//
//  ConnectWithWifeMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 09/07/21.
//

import SwiftMessages
import UIKit

final class ConnectWithPartnerMessageView: MessageView {
    
    var confirmAction: (() -> Void)?
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Connect With Your Partner"
        label.textColor = .pearlWhite
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap to connect with your partner or you can set it up later in profile settings."
        label.textColor = .pearlWhite
        label.font = UIFont.systemFont(ofSize: 18)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView(image: .qrCodeIcon)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onMessageViewDidTap(_:)))
        containerView.addGestureRecognizer(tapGesture)
        containerView.backgroundColor = .heartRed
        containerView.layer.cornerRadius = 15
        
        containerView.addSubview(self.qrCodeImageView)
        containerView.addSubview(self.customTitleLabel)
        containerView.addSubview(self.descriptionLabel)
        self.qrCodeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.width.equalTo(self.qrCodeImageView.snp.height)
        }
        self.customTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(25)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.qrCodeImageView)
            make.leading.equalTo(self.qrCodeImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.qrCodeImageView)
        }
        
        containerView.setNeedsLayout()
        containerView.layoutIfNeeded()
        return containerView
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
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25)
        }
    }
    
    @objc
    private func onMessageViewDidTap(_ sender: UITapGestureRecognizer) {
        self.confirmAction?()
    }
    
}
