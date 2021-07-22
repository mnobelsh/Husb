//
//  AlertMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 22/07/21.
//

import UIKit
import SwiftMessages
import Lottie

class AlertMessageView: MessageView {
    
    lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: .failureAnimation)
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(65)
        }
        return animationView
    }()
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .jetBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.dropShadow()
        view.layer.cornerRadius = 15
        view.addSubview(self.animationView)
        view.addSubview(self.customTitleLabel)
        
        self.animationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.animationView.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.top.bottom.equalToSuperview()
        }
        self.animationView.play()
    }
    
    deinit {
        self.animationView.stop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(title: String, type: MessageKit.AlertType) {
        self.customTitleLabel.text = title
        switch type {
        case .success:
            self.animationView = AnimationView(name: .successAnimation)
        case .failure:
            self.animationView = AnimationView(name: .failureAnimation)
        }
        self.animationView.loopMode = .playOnce
        self.animationView.animationSpeed = 1
        self.animationView.contentMode = .scaleAspectFit
        self.animationView.backgroundColor = .clear
        self.animationView.play()
    }
    
}

fileprivate extension String {
    
    static let successAnimation = "success-animation"
    static let failureAnimation = "failure-animation"
    
}

