//
//  ImageViewerMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 10/07/21.
//

import UIKit
import SwiftMessages

class ImageViewerMessageView: MessageView {
    
    // MARK: - SubViews
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Challenge Title"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .pearlWhite
        label.numberOfLines = 0
        return label
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(self.customTitleLabel)
        self.addSubview(self.imageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onBackgroundViewDidTap(_:)))
        tapGesture.cancelsTouchesInView = false
        self.backgroundView.isUserInteractionEnabled = true
        self.backgroundView.addGestureRecognizer(tapGesture)
        
        self.imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.equalTo(self.imageView.snp.top).offset(-5)
            make.height.equalTo(50)
        }
        
    }
    
    func fill(image: UIImage?, imageTitle: String) {
        self.customTitleLabel.text = imageTitle
        self.imageView.image = image
    }
    
    @objc
    private func onBackgroundViewDidTap(_ sender: UITapGestureRecognizer) {
        MessageKit.hide(id: self.id)
    }
    
}
