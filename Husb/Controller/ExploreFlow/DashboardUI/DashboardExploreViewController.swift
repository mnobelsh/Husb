//
//  DashboardExploreViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct DashboardExploreViewControllerRequest {
    
}

protocol DashboardExploreViewControllerRoute {
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    )
    
    func showChallengeListUI(
        navigationController: UINavigationController?,
        request: ChallengeListViewControllerRequest
    )
    

    func showExploreSearchUI(
        navigationController: UINavigationController?,
        request: ExploreSearchViewControllerRequest
    )
    
}

class DashboardExploreViewController: UIViewController {
    
    static func create(
        route: DashboardExploreViewControllerRoute,
        request: DashboardExploreViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DashboardExploreViewController {
        let viewController = DashboardExploreViewController()
        viewController.route = route
        viewController.tabBarItem = .init(
            title: "Explore",
            image: UIImage.exploreIcon.withTintColor(.skyBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage.exploreIcon.withTintColor(.seaBlue, renderingMode: .alwaysOriginal)
        )
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var route: DashboardExploreViewControllerRoute!
    private var request: DashboardExploreViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private var loveLanguages: [LoveLanguageDomain] = LoveLanguageDomain.list
    private var forYouAndSoulmateChallenges = ChallengeDomain.allChallenges
    private var mostSavedChallenges = ChallengeDomain.allChallenges
    private var hubbyChallenges = ChallengeDomain.allChallenges
    private var currentUser: UserDomain? {
        didSet {
            self.exploreCollectionView.reloadData()
        }
    }

    // MARK: - SubViews
    private lazy var exploreCollectionView: ExploreCollectionView = ExploreCollectionView(frame: self.view.frame)

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
        self.view.endEditing(true)
        self.disableHero()
    }
    

}

// MARK: - Private Functions
private extension DashboardExploreViewController {
    
    func setupViewDidLoad() {
        self.view.addSubview(self.exploreCollectionView)
        self.exploreCollectionView.refreshControl?.addTarget(
            self,
            action: #selector(self.onRefreshControlDidChangeValue(_:)),
            for: .valueChanged
        )
        self.exploreCollectionView.delegate = self
        self.exploreCollectionView.dataSource = self
        self.view.backgroundColor = .ghostWhite
        
        self.exploreCollectionView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        self.activateTapViewEndEditingWithGesture()
        
        MessageKit.showLoadingView()
        self.useCase.fetchUserUseCase().execute(.init(parameter: .current)) { result in
            DispatchQueue.main.async {
                self.currentUser = try? result.get().user
                MessageKit.hideLoadingView()
            }
        }
    }
    

}

// MARK: - @objc Private Functions
private extension DashboardExploreViewController {
    
    @objc
    private func onRefreshControlDidChangeValue(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            sender.endRefreshing()
        }
    }
    
}


// MARK: - DashboardExploreViewController+UICollectionViewDataSource
extension DashboardExploreViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ExploreCollectionView.Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch ExploreCollectionView.Section(rawValue: section) {
        case .header:
            return 1
        case .loveLanguage:
            return self.loveLanguages.count
        case .forYouAndSoulmate:
            return self.forYouAndSoulmateChallenges.count
        case .mostSaved:
            return self.mostSavedChallenges.count
        case .hubbyChallenges:
            return self.hubbyChallenges.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch ExploreCollectionView.Section(rawValue: indexPath.section) {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreCollectionHeaderView.identifier, for: indexPath) as? ExploreCollectionHeaderView else { return UICollectionViewCell() }
            cell.heroID = "HeaderHero"
            cell.delegate = self
            cell.fill(with: self.currentUser)
            return cell
        case .loveLanguage:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoveLanguageCollectionCell.identifier, for: indexPath) as? LoveLanguageCollectionCell else { return UICollectionViewCell() }
            cell.fill(loveLanguage: self.loveLanguages[indexPath.row])
            return cell
        case .forYouAndSoulmate:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
            cell.fill(challenge: self.forYouAndSoulmateChallenges[indexPath.row])
            return cell
        case .mostSaved:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
            cell.heroID = "Hero1"
            cell.fill(challenge: self.mostSavedChallenges[indexPath.row])
            return cell
        case .hubbyChallenges:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
            cell.fill(challenge: self.hubbyChallenges[indexPath.row])
            return cell
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else { return UICollectionReusableView() }
        switch ExploreCollectionView.Section(rawValue: indexPath.section) {
        case .loveLanguage:
            headerView.fill(title: "Love Languages")
        case .forYouAndSoulmate:
            headerView.fill(title: "For You And Soulmate")
        case .mostSaved:
            headerView.fill(title: "Most Saved")
        case .hubbyChallenges:
            headerView.fill(title: "Hubby Challenges")
        default:
            break
        }
        return headerView
    }
    
    
}

// MARK: - DashboardExploreViewController+UICollectionViewDelegate
extension DashboardExploreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        switch ExploreCollectionView.Section(rawValue: indexPath.section) {
        case .loveLanguage:
            self.route.showChallengeListUI(
                navigationController: self.navigationController,
                request: .init(forType: .loveLanguage(self.loveLanguages[indexPath.row]))
            )
        case .mostSaved:
            self.route.showDetailChallengeUI(
                navigationController: self.navigationController,
                request: .init(
                    challenge: self.mostSavedChallenges[index]
                )
            )
        case .forYouAndSoulmate:
            self.route.showDetailChallengeUI(
                navigationController: self.navigationController,
                request: .init(
                    challenge: self.forYouAndSoulmateChallenges[index]
                )
            )
        case .hubbyChallenges:
            self.route.showDetailChallengeUI(
                navigationController: self.navigationController,
                request: .init(
                    challenge: self.hubbyChallenges[index]
                )
            )
        default:
            break
        }
    }
    
}

// MARK: - DashboardExploreViewController+ExploreCollectionHeaderViewDelegate
extension DashboardExploreViewController: ExploreCollectionHeaderViewDelegate {
    
    func exploreCollectionHeaderView(_ view: ExploreCollectionHeaderView, didTapHeaderView headerView: UIView) {
        let messageViewId = UUID().uuidString
        MessageKit.showConnectWithWifeAlert(withId: messageViewId, duration: .forever) {
            guard let tabBarController = self.tabBarController, let viewControllersCount = tabBarController.viewControllers?.count  else { return }
            self.tabBarController?.selectedIndex = viewControllersCount - 1
            MessageKit.hide(id: messageViewId)
        }
    }
    
    func exploreCollectionSearchBarDidBeginEditing(
        _ searchBar: UISearchBar,
        cell: ExploreCollectionHeaderView
    ) {
        self.route.showExploreSearchUI(navigationController: self.navigationController, request: .init())
    }
    
    
    func exploreCollectionHeaderView(
        _ view: ExploreCollectionHeaderView,
        didCreateNewChallenge challenge: ChallengeDomain
    ) {
        guard let currentUser = self.currentUser else { return }
        MessageKit.showLoadingView()
        let request = SaveUserChallengeUseCaseRequest(
            currentUserId: currentUser.id,
            connectedUserId: currentUser.connectedUserId,
            challenge: challenge
        )
        self.useCase.saveUserChallengeUseCase().execute(request) { result in
            DispatchQueue.main.async {
                MessageKit.hideLoadingView()
                switch result {
                case .success:
                    MessageKit.showAlertMessageView(title: "New challenge has been added.", type: .success)
                    guard let currentUserId = self.currentUser?.id, let connectedUserId = self.currentUser?.connectedUserId else { return }
                    let notification = NotificationDomain(
                        notificationType: .challengeRequest,
                        title: "You've got a new challenge",
                        message: "new challenge have been added to your current challenge.",
                        challengeId: challenge.id,
                        date: Date(),
                        senderId: currentUserId,
                        receiverId: connectedUserId
                    )
                    self.useCase.saveNotificationUseCase().execute(SaveNotificationUseCaseRequest(notification: notification)) { _ in }
                case .failure:
                    MessageKit.showAlertMessageView(title: "Failed to create new challenge.", type: .failure)
                }
            }
        }
    }
    
    
}


