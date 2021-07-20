//
//  UIView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit
import Hero

extension UIViewController {
    
    func activateTapViewEndEditingWithGesture(
        _ gesture: UITapGestureRecognizer? = nil,
        completion: (()->Void)? = nil
    ) {
        self.view.isUserInteractionEnabled = true
        var tapGesture: UITapGestureRecognizer!
        if gesture == nil {
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onViewDidTapEndEditing(_:)))
        } else {
            tapGesture = gesture!
        }
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        completion?()
    }
    
    func configureBackButton(with image: UIImage, backgroundColor: UIColor = .skyBlue) {
        let backButton: UIButton = UIView.makeBackButton(forImage: image, backgroundColor: backgroundColor)
        backButton.addTarget(self, action: #selector(self.onBackButtonDidTap(_:)), for: .touchUpInside)
        self.view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        self.view.bringSubviewToFront(backButton)
    }
    
    
    @objc
    private func onBackButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func onViewDidTapEndEditing(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func enableHero() {
        self.hero.isEnabled = true
        self.navigationController?.hero.isEnabled = true
    }
    
    func disableHero() {
        self.hero.isEnabled = false
        self.navigationController?.hero.isEnabled = false
    }

    
}


