//
//  NotificationViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct DashboardNotificationViewControllerRequest {
    
}

protocol DashboardNotificationViewControllerRoute {
    
    func showMessageFromWifeNotificationUI(
        navigationController: UINavigationController?,
        request: MessageFromWifeNotificationViewControllerRequest
    )
    
    func showChallengeRequestNotificationUI(
        navigationController: UINavigationController?,
        request: ChallengeRequestNotificationViewControllerRequest
    )
    
    func showCompletedChallengeNotificationUI(
        navigationController: UINavigationController?,
        request: CompletedChallengeNotificationViewControllerRequest
    )
}

class DashboardNotificationViewController: UIViewController {
    
    static func create(
        route: DashboardNotificationViewControllerRoute,
        request: DashboardNotificationViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DashboardNotificationViewController {
        let viewController = DashboardNotificationViewController()
        viewController.route = route
        viewController.tabBarItem = .init(
            title: "Notification",
            image: UIImage.notificationIcon.withTintColor(.skyBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage.notificationIcon.withTintColor(.seaBlue, renderingMode: .alwaysOriginal)
        )
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }

    
    private var route: DashboardNotificationViewControllerRoute!
    private var request: DashboardNotificationViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private var notifications: [NotificationDomain] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - SubViews
    private lazy var collectionView: DashboardNotificationCollectionView = DashboardNotificationCollectionView(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }

}

// MARK: - Private Function
private extension DashboardNotificationViewController {
    
    func setupViewDidLoad() {
        self.view.backgroundColor = .ghostWhite
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func setupViewWillAppear() {
        self.enableHero()
        MessageKit.showLoadingView()
        guard let userId = UserDefaultStorage.shared.getValue(forKey: .currentUserId) as? String else { return }
        let request = FetchNotificationsUseCaseRquest(userId: userId)
        self.useCase.fetchNotificationsUseCase().execute(request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.notifications = (try? result.get().notifications) ?? []
                MessageKit.hideLoadingView()
            }
        }
    }

}

extension DashboardNotificationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DashboardNotificationCollectionView.Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch DashboardNotificationCollectionView.Section(rawValue: section) {
        case .header:
            return 1
        case .notification:
            return self.notifications.count
        default:
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch DashboardNotificationCollectionView.Section(rawValue: indexPath.section) {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionHeaderView.identifier, for: indexPath) as? NotificationCollectionHeaderView else { return UICollectionViewCell() }
            
            return cell
        case .notification:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCollectionCell.identifier, for: indexPath) as? NotificationCollectionCell else { return UICollectionViewCell() }
            cell.fill(with: self.notifications[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    

}

extension DashboardNotificationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch DashboardNotificationCollectionView.Section(rawValue: indexPath.section) {
        case .notification:
            let notification = self.notifications[indexPath.row]
            switch notification.notificationType {
            case .challengeRequest:
                self.route.showChallengeRequestNotificationUI(
                    navigationController: self.navigationController,
                    request: .init(notification: self.notifications[indexPath.row])
                )
            case .message:
                self.route.showMessageFromWifeNotificationUI(
                    navigationController: self.navigationController,
                    request: .init(
                        notification: self.notifications[indexPath.row]
                    )
                )
            case .completedChallenge:
                self.route.showCompletedChallengeNotificationUI(
                    navigationController: self.navigationController,
                    request: .init(notification: self.notifications[indexPath.row])
                )
            }
        default:
            break
        }
    }
    
}
