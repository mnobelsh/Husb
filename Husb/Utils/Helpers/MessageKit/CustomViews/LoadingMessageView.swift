//
//  LoadingMessageView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 15/07/21.
//

import UIKit
import SwiftMessages
import Lottie

class LoadingMessageView: MessageView {
    
    lazy var animationView: AnimationView = {
        let animationView = AnimationView(name: .loadingAnimation)
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundColor = .clear
        animationView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
        }
        return animationView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.addSubview(self.animationView)
        self.animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.animationView.play()
    }
    
    deinit {
        self.animationView.stop()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

fileprivate extension String {
    
    static let loadingAnimation = "loading-animation"
    
}
