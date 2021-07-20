//
//  ThirdOnBoardingViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/07/21.
//

import UIKit


class ThirdOnBoardingViewController: UIViewController {
    
    var route: OnBoardingViewControllerRoute!
    var useCase: UseCaseFactory!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: .onboardingConnect)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "CONNECT"
        return label
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.text = "Conenct you app with your partnet to maintain challenges together."
        label.textAlignment = .center
        return label
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.ghostWhite, for: .normal)
        button.backgroundColor = .seaBlue
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.addTarget(self, action: #selector(self.onNextButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.descriptionLabel)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.nextButton)
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
        self.nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
        }
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    

}

private extension ThirdOnBoardingViewController {
    
    @objc
    func onNextButtonDidTap(_ sender: UIButton) {
        let request = SaveOnBoardingStateUseCaseRequest(onboardingState: .done)
        self.useCase.saveOnBoardingStateUseCase().execute(request) { [weak self] _ in
            guard let self = self else { return }
            let request = SignInViewControllerRequest()
            self.route.showSignInUI(navigationController: self.navigationController, request: request)
        }

    }
    
}
