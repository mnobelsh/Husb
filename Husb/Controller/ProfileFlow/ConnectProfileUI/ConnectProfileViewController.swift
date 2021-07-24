//
//  ConnectProfileViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 16/07/21.
//

import UIKit

struct ConnectProfileViewControllerRequest {
    let currentUser: UserDomain
    let connectedUser: UserDomain
}

protocol ConnectProfileViewControllerRoute {
    
}

class ConnectProfileViewController: UIViewController {
    
    static func create(
        route: ConnectProfileViewControllerRoute,
        request: ConnectProfileViewControllerRequest,
        useCase: UseCaseFactory
    ) -> ConnectProfileViewController {
        let viewController = ConnectProfileViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var route: ConnectProfileViewControllerRoute!
    private var request: ConnectProfileViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    // MARK: - SubViews
    lazy var currentUserContainerView: UIView = ConnectProfileViewController.makeProfileContainerView(for: "You", user: self.request.currentUser)
    lazy var connectedUserContainerView: UIView = ConnectProfileViewController.makeProfileContainerView(for: self.request.connectedUser.name, user: self.request.connectedUser)
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        let titleText = NSMutableAttributedString(
            string: "Yaay! we found your partner\n\n",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 35),
                .foregroundColor: UIColor.jetBlack
            ]
        )
        let subText = NSAttributedString(
            string: "Please tap Connect Button to make a connection with your partner it enable both of you to share challenges together.",
            attributes: [
                .font: UIFont.systemFont(ofSize: 25),
                .foregroundColor: UIColor.darkGray
            ]
        )
        titleText.append(subText)
        label.attributedText = titleText
        return label
    }()
    lazy var loveIcon: UIImageView = {
        let imageView = UIImageView(image: .heartCircle)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    lazy var connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Connect", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.setTitleColor(.ghostWhite, for: .normal)
        button.backgroundColor = .seaBlue
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        button.addTarget(
            self,
            action: #selector(self.onConnectButtonTouchUpInside(_:)),
            for: .touchUpInside
        )
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupViewDidAppear()
    }
    
    private func setupViewDidLoad() {
        self.view.backgroundColor = .funYellow
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.loveIcon)
        self.view.addSubview(self.currentUserContainerView)
        self.view.addSubview(self.connectedUserContainerView)
        self.view.addSubview(self.connectButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(self.view.frame.width*0.7)
        }
        self.loveIcon.snp.makeConstraints { make in
            make.width.height.equalTo(35)
            make.center.equalToSuperview()
        }
        self.currentUserContainerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview()
            make.height.equalTo(self.currentUserContainerView.snp.width).multipliedBy(2)
            make.centerY.equalTo(self.loveIcon)
        }
        self.connectedUserContainerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.height.equalTo(self.connectedUserContainerView.snp.width).multipliedBy(2)
            make.centerY.equalTo(self.loveIcon)
        }
        self.connectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.height.equalTo(48)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
        }
    }
    
    private func setupViewDidAppear() {
        self.currentUserContainerView.snp.remakeConstraints { make in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(20)
            make.trailing.equalTo(self.loveIcon.snp.leading).offset(-20)
            make.height.equalTo(self.currentUserContainerView.snp.width).multipliedBy(2)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(self.loveIcon)
        }
        self.connectedUserContainerView.snp.remakeConstraints { make in
            make.top.greaterThanOrEqualTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.equalTo(self.loveIcon.snp.trailing).offset(20)
            make.height.equalTo(self.connectedUserContainerView.snp.width).multipliedBy(2)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(self.loveIcon)
        }
        UIView.animate(withDuration: 0.6) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func onConnectButtonTouchUpInside(_ sender: UIButton) {
        MessageKit.showLoadingView()
        var updatedCurrentUser = self.request.currentUser
        var updatedConnectedUser = self.request.connectedUser
        updatedCurrentUser.connectedUserId = self.request.connectedUser.id
        updatedConnectedUser.connectedUserId = self.request.currentUser.id
        self.useCase.saveUserUseCase()
            .execute(
                .init(user: updatedCurrentUser)
            ) { result in
                switch result {
                case .success:
                    self.useCase.saveUserUseCase()
                        .execute(
                            .init(user: updatedConnectedUser)
                        ) { result in
                            switch result {
                            case .success:
                                DispatchQueue.main.async {
                                    MessageKit.hideLoadingView()
                                    var title = "Success to connect with your partner."
                                    switch updatedCurrentUser.role.type {
                                    case .hubby:
                                        title = "Success to connect with your wife."
                                    case .wife:
                                        title = "Success to connect with your husband."
                                    default:
                                        break
                                    }
                                    MessageKit.showAlertMessageView(title: title, type: .success)
                                }
                            case .failure:
                                DispatchQueue.main.async {
                                    MessageKit.hideLoadingView()
                                    var title = "Failed to connect with your partner."
                                    switch updatedCurrentUser.role.type {
                                    case .hubby:
                                        title = "Failed to connect with your wife."
                                    case .wife:
                                        title = "Failed to connect with your husband."
                                    default:
                                        break
                                    }
                                    MessageKit.showAlertMessageView(title: title, type: .failure)
                                }
                            }
                        }
                case .failure:
                    DispatchQueue.main.async {
                        MessageKit.hideLoadingView()
                        MessageKit.showAlertMessageView(title: "Action failed.", type: .failure)
                    }
                }
            }
        self.dismiss(animated: true, completion: nil)
    }

}


extension ConnectProfileViewController {
    
    static func makeProfileContainerView(for name: String, user: UserDomain) -> UIView {
        let view = UIView()
        let image = user.role.type == .hubby ? UIImage.hubbyIcon : UIImage.wifeyIcon
        let imageView = UIImageView(image: user.profileImage ?? image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .pearlWhite
        imageView.layer.cornerRadius = 10
        
        let roleLabel = UILabel()
        roleLabel.text = user.role.title
        roleLabel.textColor = user.role.type == .hubby ? .seaBlue : .heartRed
        roleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        roleLabel.adjustsFontSizeToFitWidth = true
        roleLabel.minimumScaleFactor = 0.6
        roleLabel.textAlignment = .center
        roleLabel.numberOfLines = 0
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.font = UIFont.boldSystemFont(ofSize: 22)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
        nameLabel.textColor = .jetBlack
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        
        view.addSubview(roleLabel)
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        roleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(25)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(roleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(5)
        }
        
        return view
    }
    
}
