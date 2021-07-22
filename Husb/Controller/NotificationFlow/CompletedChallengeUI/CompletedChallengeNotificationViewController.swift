//
//  CompletedChallengeNotificationViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 22/07/21.
//

import UIKit

struct CompletedChallengeNotificationViewControllerRequest {
    var notification: NotificationDomain
}

protocol CompletedChallengeNotificationViewControllerRoute {
    
}

class CompletedChallengeNotificationViewController: UIViewController {
    
    static func create(
        route: CompletedChallengeNotificationViewControllerRoute,
        request: CompletedChallengeNotificationViewControllerRequest,
        useCase: UseCaseFactory
    ) -> CompletedChallengeNotificationViewController {
        let viewController = CompletedChallengeNotificationViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var route: CompletedChallengeNotificationViewControllerRoute!
    private var request: CompletedChallengeNotificationViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private var challenge: ChallengeDomain? {
        didSet {
            guard let challenge = self.challenge else { return }
            self.titleLabel.text = "Your husband has been completed \"\(challenge.title)\" challenge"
        }
    }
    private var currentUser: UserDomain? {
        didSet {
            guard let currentUserId = self.currentUser?.id, let challengeId = self.request.notification.challengeId else { return }
            MessageKit.showLoadingView()
            self.useCase.fetchUserChallengesUseCase().execute(
                .init(
                    userId: currentUserId,
                    objective: .byChallengeId(challengeId)
                )) { result in
                DispatchQueue.main.async {
                    self.challenge = try? result.get().challenges.first
                    MessageKit.hideLoadingView()
                }
            }
        }
    }
    
    // MARK: - SubViews
    lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 15
        view.dropShadow()
        
        view.addSubview(self.heartImageView)
        view.addSubview(self.titleLabel)
        view.addSubview(self.messageLabel)
        view.addSubview(self.textView)
        view.addSubview(self.doneButton)
        self.heartImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(self.heartImageView.snp.bottom).offset(10)
            make.height.equalTo(35)
        }
        self.messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.height.equalTo(35)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        self.textView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.top.equalTo(self.messageLabel.snp.bottom).offset(20)
            make.bottom.equalTo(self.doneButton.snp.top).offset(-20)
        }
        self.doneButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(48)
        }
        return view
    }()
    lazy var heartImageView: UIImageView = {
        let imageView = UIImageView(image: .heartCircle)
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.textAlignment = .center
        return label
    }()
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .jetBlack
        label.numberOfLines = 0
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
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.dropShadow()
        textView.layer.cornerRadius = 12
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.seaBlue.cgColor
        textView.backgroundColor = .ghostWhite
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
        return textView
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send ❤️", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.jetBlack, for: .normal)
        button.backgroundColor = .seaBlue
        button.dropShadow(
            withColor: .darkGray,
            opacity: 0.5,
            offset: .init(width: 1.5, height: 1.5)
        )
        button.layer.cornerRadius = 15
        button.addTarget(
            self,
            action: #selector(self.onSendButtonDidTap(_:)),
            for: .touchUpInside
        )
        return button
    }()

    private var loveMessage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
        MessageKit.showLoadingView()
        self.useCase.fetchUserUseCase().execute(.init(parameter: .current)) { result in
            DispatchQueue.main.async {
                self.currentUser = try? result.get().user
                MessageKit.hideLoadingView()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableHero()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }

    @objc
    private func onSendButtonDidTap(_ sender: UIButton) {
        guard let currentUserId = self.currentUser?.id, let connectedUserId = self.currentUser?.connectedUserId, let challenge = self.challenge else { return }
        let notification = NotificationDomain(
            id: UUID().uuidString,
            notificationType: .message,
            title: "Appreciation for completing \"\(challenge.title)\" challenge",
            message: self.loveMessage,
            challengeId: self.request.notification.challengeId,
            date: Date(),
            isRead: false,
            senderId: currentUserId,
            receiverId: connectedUserId
        )
        let request = SaveNotificationUseCaseRequest(notification: notification)
        MessageKit.showLoadingView()
        self.useCase.saveNotificationUseCase().execute(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Success to send your appreciation letter to your husband.", type: .success)
                case .failure:
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Unable to send your appreciation letter, please check your internet connection.", type: .failure)
                }
            }
        }
    }
}

extension CompletedChallengeNotificationViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.loveMessage = textView.text
    }
    
}

private extension CompletedChallengeNotificationViewController {
    
    func setupViewDidLoad() {
        self.configureBackButton(with: .chevronLeft, backgroundColor: .seaBlue)
        self.view.backgroundColor = .romanticPink
        self.view.addSubview(self.contentContainerView)
        self.view.addSubview(self.dateLabel)
        self.contentContainerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.width/5)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-self.view.frame.width/5)
        }
        self.dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentContainerView.snp.bottom).offset(5)
            make.trailing.equalTo(self.contentContainerView)
            make.height.equalTo(30)
        }
        
        self.view.heroID = "CompletedChallengeMessage"
        self.messageLabel.text = self.request.notification.message
        self.dateLabel.text = self.request.notification.date.getString(withFormat: "EEEE,d MMMM YYYY")
    }
    
}
