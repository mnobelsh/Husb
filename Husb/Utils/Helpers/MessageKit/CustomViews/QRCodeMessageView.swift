//
//  QRCodeMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 15/07/21.
//

import UIKit
import SwiftMessages

class QRCodeMessageView: MessageView {
    
    lazy var userId: String = ""
    
    lazy var qrCodeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.backgroundColor = .clear
        imageview.clipsToBounds = true
        return imageview
    }()
    
    lazy var qrCodeImageViewContainerView: UIView = {
        let view = UIView()
        let backgroundImageView = UIImageView(image: .qrBackground)
        backgroundImageView.contentMode = .scaleAspectFit
        
        view.addSubview(backgroundImageView)
        view.addSubview(self.qrCodeImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.qrCodeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(UIScreen.main.bounds.width*0.4)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.bottom.equalToSuperview().offset(-UIScreen.main.bounds.width*0.4)
        }
        
        return view
        
    }()
    
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Use your QR code below to connect with you partner."
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .pearlWhite
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        self.addSubview(self.customTitleLabel)
        self.addSubview(self.qrCodeImageViewContainerView)
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(60)
        }
        self.qrCodeImageViewContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUserId(_ userId: String) {
        self.userId = userId
        self.qrCodeImageView.image = self.userId.generateQRCode()
    }
    
}
