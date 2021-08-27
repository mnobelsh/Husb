//
//  DetailNotificationViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/07/21.
//

import UIKit

struct MessageFromWifeNotificationViewControllerRequest {
    var notification: NotificationDomain
}

protocol MessageFromWifeNotificationViewControllerRoute {
    
}

class MessageFromWifeNotificationViewController: UIViewController {
    
    static func create(
        route: MessageFromWifeNotificationViewControllerRoute,
        request: MessageFromWifeNotificationViewControllerRequest
    ) -> MessageFromWifeNotificationViewController {
        let viewController = MessageFromWifeNotificationViewController()
        viewController.route = route
        viewController.request = request
        return viewController
    }
    
    private var route: MessageFromWifeNotificationViewControllerRoute!
    private var request: MessageFromWifeNotificationViewControllerRequest!
    
    // MARK: - SubViews
    lazy var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .pearlWhite
        view.layer.cornerRadius = 15
        view.dropShadow()
        
        view.addSubview(self.heartImageView)
        view.addSubview(self.titleLabel)
        view.addSubview(self.messageTextView)
        self.heartImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.top.equalTo(self.heartImageView.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        self.messageTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.bottom.equalToSuperview().offset(-20)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
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
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .jetBlack
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        return label
    }()
    lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 23)
        textView.textColor = .jetBlack
        textView.isEditable = false
        textView.textAlignment = .center
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.seaBlue.cgColor
        textView.layer.cornerRadius = 15
        textView.backgroundColor = .ghostWhite
        return textView
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

private extension MessageFromWifeNotificationViewController {
    
    func setupViewDidLoad() {
        self.configureBackButton(with: .chevronLeft, backgroundColor: .romanticPink)
        self.view.backgroundColor = .skyBlue
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
        
        self.view.heroID = "MessageFromWifeHero"
        self.titleLabel.text = self.request.notification.title
        self.messageTextView.text = self.request.notification.message
        self.dateLabel.text = self.request.notification.date.getString(withFormat: "EEEE,d MMMM YYYY")
    }
    
}
