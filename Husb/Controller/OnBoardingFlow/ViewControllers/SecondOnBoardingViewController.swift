//
//  SecondOnBoardingViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/07/21.
//

import UIKit

class SecondOnBoardingViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .onboardingAppreciation)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "APPRECIATION"
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.text = "Appreciate your partner for completing some challenges."
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.titleLabel)
        self.imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.width/4)
            make.height.equalTo(self.imageView.snp.width)
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-85)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(25)
            make.top.equalTo(self.imageView.snp.bottom).offset(40)
        }
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }

}
