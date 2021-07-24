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
    
    lazy var successAnimationView: AnimationView = {
        let animationView = AnimationView(name: .successAnimation)
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(65)
        }
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.7
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        return animationView
    }()
    lazy var failureAnimationView: AnimationView = {
        let animationView = AnimationView(name: .failureAnimation)
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(65)
        }
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 0.7
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        return animationView
    }()
    lazy var animationContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.snp.makeConstraints { make in
            make.width.height.equalTo(65)
        }
        view.addSubview(self.successAnimationView)
        view.addSubview(self.failureAnimationView)
        self.successAnimationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.failureAnimationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        return view
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
        view.addSubview(self.animationContainerView)
        view.addSubview(self.customTitleLabel)
        
        self.animationContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        self.customTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.animationContainerView.snp.bottom).offset(15)
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
    }
    
    deinit {
        self.successAnimationView.stop()
        self.failureAnimationView.stop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(title: String, type: MessageKit.AlertType) {
        self.customTitleLabel.text = title
        switch type {
        case .success:
            self.successAnimationView.isHidden = false
            self.failureAnimationView.isHidden = true
            self.successAnimationView.play()
        case .failure:
            self.successAnimationView.isHidden = true
            self.failureAnimationView.isHidden = false
            self.failureAnimationView.play()
        }
    }
    
}

fileprivate extension String {
    
    static let successAnimation = "success-animation"
    static let failureAnimation = "failure-animation"
    
}

