//
//  ChallengeRequestNotificationViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

struct ChallengeRequestNotificationViewControllerRequest {
    var notification: NotificationDomain
}

protocol ChallengeRequestNotificationViewControllerRoute {
    
}


class ChallengeRequestNotificationViewController: UIViewController {

    static func create(
        route: ChallengeRequestNotificationViewControllerRoute,
        request: ChallengeRequestNotificationViewControllerRequest
    ) -> ChallengeRequestNotificationViewController {
        let viewController = ChallengeRequestNotificationViewController()
        viewController.route = route
        viewController.request = request
        return viewController
    }
    
    private var route: ChallengeRequestNotificationViewControllerRoute!
    private var request: ChallengeRequestNotificationViewControllerRequest!
    
    // MARK: - SubViews
    lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 15
        view.dropShadow()
        
        view.addSubview(self.starImageView)
        view.addSubview(self.descriptionLabel)
        view.addSubview(self.titleLabel)
        view.addSubview(self.dueDateLabel)
        view.addSubview(self.changeDateButton)
        view.addSubview(self.buttonStackView)
        self.starImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        self.descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(self.starImageView.snp.bottom).offset(20)
            make.height.equalTo(20)
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.height.equalTo(60)
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(20)
        }
        self.dueDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        self.changeDateButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(25)
        }
        self.buttonStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.greaterThanOrEqualTo(self.dueDateLabel.snp.bottom).offset(50)
            make.bottom.equalTo(self.changeDateButton.snp.top).offset(-35)
            make.height.equalTo(150)
        }
        return view
    }()
    lazy var starImageView: UIImageView = {
        let imageView = UIImageView(image: .starCircle)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
        }
        return imageView
    }()
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .jetBlack
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var dueDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .jetBlack
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .pearlWhite
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .right
        return label
    }()
    lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .funYellow
        button.setTitle("Accept", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.setTitleColor(.jetBlack, for: .normal)
        button.addTarget(self, action: #selector(self.onAcceptButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var saveItForLaterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .pearlWhite
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.funYellow.cgColor
        button.setTitle("Save it for later", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.layer.cornerRadius = 12
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        button.setTitleColor(.jetBlack, for: .normal)
        button.addTarget(self, action: #selector(self.onSaveItForLaterButtonDidTap(_:)), for: .touchUpInside)
        return button
    }()
    lazy var changeDateButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("CHANGE THE DATE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.jetBlack, for: .normal)
        button.addTarget(
            self,
            action: #selector(self.onChangeDateButtonDidTap(_:)),
            for: .touchUpInside
        )
        return button
    }()
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.acceptButton,
            self.saveItForLaterButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }

}

private extension ChallengeRequestNotificationViewController {
    
    func setupViewDidLoad() {
        self.view.backgroundColor = .funYellow
        self.view.addSubview(self.contentContainerView)
        self.view.addSubview(self.dateLabel)
        self.contentContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.width/4)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-self.view.frame.width/4)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentContainerView.snp.bottom).offset(5)
            make.trailing.equalTo(self.contentContainerView)
            make.height.equalTo(30)
        }
        self.view.heroID = "ChallengeRequestHero"
        self.descriptionLabel.text = "You’ve got a challenge!"
        self.titleLabel.text = self.request.notification.challenge?.title
        guard let challengeDueDate = self.request.notification.challenge?.dueDate else { return }
        self.dueDateLabel.text = "Due Date: \(challengeDueDate.getString(withFormat: "d MMMM YYYY"))"
        self.dateLabel.text = self.request.notification.date.getString(withFormat: "EEEE,d MMMM YYYY")
        self.configureBackButton(with: .chevronLeft, backgroundColor: .romanticPink)
    }
    
    @objc
    func onAcceptButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    func onSaveItForLaterButtonDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    func onChangeDateButtonDidTap(_ sender: UIButton) {
        let messageId = UUID().uuidString
        let confirmAction = { (date: Date?) in
            guard let _ = date else { return }
            MessageKit.hide(id: messageId)
        }
        let dismissAction = {
            MessageKit.hide(id: messageId)
        }
        MessageKit.showDatePickerView(
            withId: messageId,
            confirmAction: confirmAction,
            dismissAction: dismissAction
        )
    }

}
