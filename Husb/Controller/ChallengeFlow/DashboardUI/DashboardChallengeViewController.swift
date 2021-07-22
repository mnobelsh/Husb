//
//  DashboardChallengeViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit
import SnapKit
import SkeletonView

struct DashboardChallengeViewControllerRequest {

}

protocol DashboardChallengeViewControllerRoute {
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    )
    
    func showChallengeListUI(
        navigationController: UINavigationController?,
        request: ChallengeListViewControllerRequest
    )
    
}

class DashboardChallengeViewController: UIViewController {
    
    // MARK: - Properties
    private var route: DashboardChallengeViewControllerRoute!
    private var request: DashboardChallengeViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private var currentUser: UserDomain? {
        didSet {
            guard let currentUserId = self.currentUser?.id else { return }
            self.fetchUserChallenges(userId: currentUserId) {
                self.challengeCollectionView.reloadData()
                self.challengeCollectionView.stopSkeletonAnimation()
                self.challengeCollectionView.hideSkeleton()
            }
            guard let connectedUserId = self.currentUser?.connectedUserId else { return }
            self.useCase.fetchUserUseCase().execute(.init(parameter: .byId(userId: connectedUserId))) { result in
                DispatchQueue.main.async {
                    self.connectedUser = try? result.get().user
                }
            }
        }
    }
    private var connectedUser: UserDomain? {
        didSet {
            self.challengeCollectionView.performBatchUpdates {
                self.challengeCollectionView.reloadSections(IndexSet(integer: DashboardChallengeCollectionView.Section.mood.rawValue))
            }
        }
    }
    
    private var currentChallenges: [ChallengeDomain] = []
    private var simpleThings: [ChallengeDomain] = ChallengeDomain.simpleThings
    private var savedChallenges: [ChallengeDomain] = []
    private var wifeMood: MoodDomain = .init(type: .happy)
    private var tips: TipsDomain = TipsDomain.tipsList.first!
    
    // MARK: - SubViews
    private lazy var challengeCollectionView: DashboardChallengeCollectionView = DashboardChallengeCollectionView(frame: self.view.frame)
    
    static func create(
        route: DashboardChallengeViewControllerRoute,
        request: DashboardChallengeViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DashboardChallengeViewController {
        let viewController = DashboardChallengeViewController()
        viewController.route = route
        viewController.tabBarItem = .init(
            title: "Challenge",
            image: UIImage.challengeIcon.withTintColor(.skyBlue, renderingMode: .alwaysOriginal),
            selectedImage: UIImage.challengeIcon.withTintColor(.seaBlue, renderingMode: .alwaysOriginal)
        )
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }


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


// MARK: - Private Functions
private extension DashboardChallengeViewController {
    
    func setupViewDidLoad() {
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.challengeCollectionView)
        self.challengeCollectionView.refreshControl?.addTarget(
            self,
            action: #selector(self.onRefreshControlDidChangeValue(_:)),
            for: .valueChanged
        )
        self.challengeCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.setupCollectionView()
        self.challengeCollectionView.isSkeletonable = true
    }
    
    func setupViewWillAppear() {
        self.fetchUser()
        self.enableHero()
    }
    
    func setupCollectionView() {
        self.challengeCollectionView.dataSource = self
        self.challengeCollectionView.delegate = self
    }
    
    func fetchUser() {
        self.useCase.fetchUserUseCase().execute(.init(parameter: .current)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.currentUser = response.user
                case .failure:
                    break
                }
            }
        }
    }
    
    func fetchUserChallenges(userId: String, completion: @escaping() -> Void) {
        self.challengeCollectionView.showAnimatedGradientSkeleton()
        let requestValue = FetchUserChallengesUseCaseRequest(
            userId: userId,
            objective: .all
        )
        self.useCase.fetchUserChallengesUseCase().execute(requestValue) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .failure:
                    completion()
                case .success(let response):
                    self.savedChallenges = response.challenges.sortBy(.addedDate, order: .ascending)
                    self.currentChallenges = response.challenges.filter({$0.isActive && !$0.isCompleted}).sortBy(.dueDate, order: .ascending)
                    completion()
                }
            }
        }
    }
    
}

// MARK: - @objc Fcuntions
private extension DashboardChallengeViewController {
    
    @objc
    private func onRefreshControlDidChangeValue(_ sender: UIRefreshControl) {
        guard let currentUserId = self.currentUser?.id else { return }
        sender.beginRefreshing()
        self.fetchUserChallenges(userId: currentUserId) {
            sender.endRefreshing()
            self.challengeCollectionView.reloadData()
            self.challengeCollectionView.stopSkeletonAnimation()
            self.challengeCollectionView.hideSkeleton()
        }
    }
    
}

// MARK: - ChallengeViewController+UICollectionViewDataSource
extension DashboardChallengeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DashboardChallengeCollectionView.Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = DashboardChallengeCollectionView.Section(rawValue: section)
        switch section {
        case .currentChallenge:
            guard !self.currentChallenges.isEmpty else {
                return 1
            }
            return self.currentChallenges.count
        case .simpleThings:
            return self.simpleThings.count
        case .mood:
            return 1
        case .savedChallenge:
            guard !self.savedChallenges.isEmpty else {
                return 1
            }
            return self.savedChallenges.count
        case .tips:
            return 1
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = DashboardChallengeCollectionView.Section(rawValue: indexPath.section)

        switch section {
        case .currentChallenge:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentChallengeCollectionCell.identifier, for: indexPath) as? CurrentChallengeCollectionCell else { return UICollectionViewCell() }
            cell.isSkeletonable = true
            if self.currentChallenges.isEmpty {
                cell.fill(challenge: ChallengeDomain.empty)
            } else {
                cell.fill(challenge: self.currentChallenges[indexPath.row])
            }
            cell.stopSkeletonAnimation()
            cell.hideSkeleton()
            return cell
        case .simpleThings:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleThingsCollectionCell.identifier, for: indexPath) as? SimpleThingsCollectionCell  else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fill(with: self.simpleThings[indexPath.row])
            return cell
        case .mood:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WifeMoodCollectionCell.identifier, for: indexPath) as? WifeMoodCollectionCell  else { return UICollectionViewCell() }
            cell.isSkeletonable = true
            let role = self.currentUser?.role.type ?? .couple
            switch role {
            case .hubby:
                if let connectedUser = self.connectedUser {
                    cell.fill(mood: connectedUser.mood ?? .happy, role: .hubby)
                } else {
                    cell.fill(description: "You haven't been connected with your wife.")
                }
            case .wife:
                cell.fill(mood: self.currentUser?.mood ?? .happy, role: .wife)
            default:
                break
            }
            return cell
            
        case .savedChallenge:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
            cell.isSkeletonable = true
            if self.savedChallenges.isEmpty {
                cell.fill(title: "You Don't Have Any Saved Challenges Yet", image: ChallengeDomain.empty.posterImage)
            } else {
                cell.fill(challenge: self.savedChallenges[indexPath.row])
            }
            cell.stopSkeletonAnimation()
            cell.hideSkeleton()
            return cell
            
        case .tips:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsCollectionCell.identifier, for: indexPath) as? TipsCollectionCell else { return UICollectionViewCell() }
            cell.isSkeletonable = true
            cell.fill(tips: self.tips)
            return cell
            
        case .none:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView, let section = DashboardChallengeCollectionView.Section(rawValue: indexPath.section) else { return UICollectionReusableView() }
        
        switch section {
        case .currentChallenge:
            headerView.fill(title: "Current Challenges")
        case .simpleThings:
            headerView.fill(title: "Simple Things That Matters")
        case .mood:
            headerView.fill(title: "Wife's Daily Mood")
        case .savedChallenge:
            headerView.fill(title: "Saved", seeAllButtonIsEnabled: true, at: indexPath)
            headerView.delegate = self
        case .tips:
            headerView.fill(title: "Tips", seeAllButtonIsEnabled: true, at: indexPath)
            headerView.delegate = self
        }
        
        return headerView
    }
    
}

// MARK: - ChallengeViewController+UICollectionViewDelegate
extension DashboardChallengeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch DashboardChallengeCollectionView.Section(rawValue: indexPath.section) {
        case .currentChallenge:
            if self.currentChallenges.isEmpty {
                self.tabBarController?.selectedIndex = 1
            } else {
                self.route.showDetailChallengeUI(
                    navigationController: self.navigationController,
                    request: .init(challenge: self.currentChallenges[indexPath.row])
                )
            }
        case .savedChallenge:
            if self.savedChallenges.isEmpty {
                self.tabBarController?.selectedIndex = 1
            } else {
                self.route.showDetailChallengeUI(
                    navigationController: self.navigationController,
                    request: .init(challenge: self.savedChallenges[indexPath.row])
                )
            }
        case .mood:
            guard let user = self.currentUser, user.role.type == .wife else { return }
            let viewId = UUID().uuidString
            let confirmAction = { (_ selectedMood: MoodDomain) in
                var savedUser = user
                savedUser.mood = selectedMood
                let request = SaveUserUseCaseRequest(user: savedUser)
                self.useCase.saveUserUseCase().execute(request) { _ in
                    DispatchQueue.main.async {
                        self.fetchUser()
                        MessageKit.hide(id: viewId)
                    }
                }
                
            }
            MessageKit.showMoodPickerView(
                withId: viewId,
                confirmAction: confirmAction
            )
        default:
            break
        }
    }
    
}

// MARK: - DashboardChallengeViewController+SimpleThingsCollectionCellDelegate
extension DashboardChallengeViewController: SimpleThingsCollectionCellDelegate {
    
    func simpleThingsCollectionCell(
        _ cell: SimpleThingsCollectionCell,
        didTap checkMarkButton: UIButton
    ) {
        
    }
    
}

extension DashboardChallengeViewController: SectionHeaderViewDelegate {
    
    func sectionHeaderViewDidTapSeeAll(_ button: UIButton, view: SectionHeaderView, at indexPath: IndexPath?) {
        guard let sectionIndex = indexPath?.section, let section = DashboardChallengeCollectionView.Section(rawValue: sectionIndex) else { return }
        switch section {
        case .savedChallenge:
            guard !self.savedChallenges.isEmpty else { return }
            self.route.showChallengeListUI(
                navigationController: self.navigationController,
                request: .init(forType: .saved(self.savedChallenges))
            )
        case .tips:
            self.route.showChallengeListUI(
                navigationController: self.navigationController,
                request: .init(forType: .tips(TipsDomain.tipsList))
            )
        default:
            break
        }
        

    }
    
}

extension DashboardChallengeViewController: SkeletonCollectionViewDataSource {
    
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {
        return DashboardChallengeCollectionView.Section.allCases.count
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        switch DashboardChallengeCollectionView.Section(rawValue: indexPath.section) {
        case .currentChallenge:
            return CurrentChallengeCollectionCell.identifier
        case .simpleThings:
            return SimpleThingsCollectionCell.identifier
        case .mood:
            return WifeMoodCollectionCell.identifier
        case .savedChallenge:
            return DefaultChallengeCollectionCell.identifier
        case .tips:
            return TipsCollectionCell.identifier
        default:
            return ""
        }
    }

}
