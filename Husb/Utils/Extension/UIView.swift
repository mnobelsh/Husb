//
//  UIView.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 03/07/21.
//

import UIKit


extension UIView {
    
    static func makeBackButton(forImage image: UIImage, backgroundColor: UIColor = .skyBlue) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = backgroundColor
        button.setImage(image.withTintColor(.jetBlack, renderingMode: .alwaysOriginal), for: .normal)
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.snp.makeConstraints { make in
            make.height.equalTo(35)
            make.width.equalTo(35)
        }
        button.dropShadow()
        button.layer.cornerRadius = 8
        return button
    }
    
    func dropShadow(
        withColor color: UIColor = .spaceGrey,
        opacity: Float = 1,
        offset: CGSize = .init(width: 0.5, height: 0.5)
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .init(width: 0.5, height: 0.5)
    }
    
}
