//
//  DetailChallengeViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 20/06/21.
//

import UIKit


struct DetailChallengeViewControllerRequest {
    let challenge: ChallengeDomain
}

protocol DetailChallengeViewControllerRoute {
    
    func showDashboardProfileUI(
        navigationController: UINavigationController?,
        request: DashboardProfileViewControllerRequest
    )
    
}

class DetailChallengeViewController: UIViewController {
    
    private var route: DetailChallengeViewControllerRoute!
    private var request: DetailChallengeViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private var currentUser: UserDomain? {
        didSet {
            self.fetchUserChallenges()
            self.collectionView.reloadData()
        }
    }
    private var challenge: ChallengeDomain? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - SubViews
    private lazy var collectionView: DetailChallengeCollectionView = DetailChallengeCollectionView(frame: self.view.bounds)
    
    
    static func create(
        route: DetailChallengeViewControllerRoute,
        request: DetailChallengeViewControllerRequest,
        useCase: UseCaseFactory
    ) -> DetailChallengeViewController {
        let viewController = DetailChallengeViewController()
        viewController.route = route
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
        self.fetchCurrentUser()
        self.enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }
    
}

// MARK: - Private Functions
private extension DetailChallengeViewController {
    
    func setupViewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.configureBackButton(with: .chevronDown)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    
    func showCompletedChallengeMessage() {
        let messageViewId = UUID().uuidString
        let confirmAction = {
            MessageKit.hide(id: messageViewId)
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        let dismissAction = {
            MessageKit.hide(id: messageViewId)
        }
        MessageKit.showCompletedChallengeMessage(
            withId: messageViewId,
            confirmAction: confirmAction,
            dismissAction: dismissAction
        )
    }
    
    func showSelectDateView() {
        let messageViewId = UUID().uuidString
        let confirmationAction = { (date: Date?) in
            if let _ = date {
                self.challenge?.isActive = true
                self.collectionView.reloadData()
            }
            MessageKit.hide(id: messageViewId)
        }
        let dismissAction = {
            MessageKit.hide(id: messageViewId)
        }
        MessageKit.showDatePickerView(
            withId: messageViewId,
            confirmAction: confirmationAction,
            dismissAction: dismissAction
        )
    }
    
    func fetchCurrentUser() {
        MessageKit.showLoadingView()
        self.useCase.fetchUserUseCase().execute(.init(parameter: .current)) { result in
            guard let currentUser = (try? result.get())?.user else { return }
            DispatchQueue.main.async {
                self.currentUser = currentUser
            }
        }
    }
    
    func fetchUserChallenges() {
        guard let userId = self.currentUser?.id else { return }
        let request = FetchUserChallengesUseCaseRequest(
            userId: userId,
            objective: .byChallengeId(self.request.challenge.id)
        )
        self.useCase.fetchUserChallengesUseCase().execute(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let challenge = response.challenges.first {
                        self.challenge = challenge
                    } else {
                        self.challenge = self.request.challenge
                    }
                    MessageKit.hideLoadingView()
                case .failure:
                    MessageKit.hideLoadingView()
                    MessageKit.showAlertMessageView(title: "Unable to perform request, please check your internet connection.", type: .failure)
                }
            }
        }
    }
    
    func saveChallenge(completion: @escaping(ChallengeDomain?) -> Void) {
        guard let currentUser = self.currentUser, let connectedUserId = currentUser.connectedUserId, let savedChallenge = self.challenge else { return }
        let request = SaveUserChallengeUseCaseRequest(
            currentUserId: currentUser.id,
            connectedUserId: connectedUserId,
            challenge: savedChallenge
        )
        if savedChallenge.isCompleted, currentUser.role.type == .hubby {
            let notification = NotificationDomain(
                id: UUID().uuidString,
                notificationType: .completedChallenge,
                title: "Your husband has finished his challenge.",
                message: "Write down your appreciation message for your husband.",
                challengeId: savedChallenge.id,
                date: Date(),
                isRead: false,
                senderId: currentUser.id,
                receiverId: connectedUserId
            )
            self.useCase.saveNotificationUseCase().execute(.init(notification: notification)) { _ in }
        }
        self.useCase.saveUserChallengeUseCase().execute(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(response.challenge)
                case .failure:
                    completion(nil)
                }
            }
        }
    }
}

// MARK: - DetailChallengeViewController+UICollectionViewDataSource
extension DetailChallengeViewController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard self.challenge != nil else { return 0 }
        return DetailChallengeCollectionView.Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.challenge != nil else { return 0 }
        switch DetailChallengeCollectionView.Section(rawValue: section) {
        case .header,.action,.description,.funFacts:
            return 1
        case .steps:
            return self.challenge?.steps.count ?? 0
        default:
            return 0
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch DetailChallengeCollectionView.Section(rawValue: indexPath.section) {
        case .header :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailChallengeCollectionHeaderView.identifier, for: indexPath) as? DetailChallengeCollectionHeaderView else { return UICollectionViewCell() }
            guard let challenge = self.challenge else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fill(challenge: challenge)
            return cell
        case .action:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailChallengeActionCollectionCell.identifier, for: indexPath) as? DetailChallengeActionCollectionCell else { return UICollectionViewCell() }
            guard let challenge = self.challenge else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fill(with: challenge)
            return cell
        case .description:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailChallengeDescriptionCollectionCell.identifier, for: indexPath) as? DetailChallengeDescriptionCollectionCell else { return UICollectionViewCell() }
            guard let challenge = self.challenge else { return UICollectionViewCell() }
            cell.fill(with: challenge)
            return cell
        case .steps:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailChallengeStepCollectionCell.identifier, for: indexPath) as? DetailChallengeStepCollectionCell else { return UICollectionViewCell() }
            guard let challenge = self.challenge else { return UICollectionViewCell() }
            let index = indexPath.row
            cell.delegate = self
            cell.fill(
                with: challenge.steps[index],
                isEnabled: challenge.isActive
            )
            return cell
        case .funFacts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailChallengeFunFactCollectionCell.identifier, for: indexPath) as? DetailChallengeFunFactCollectionCell else { return UICollectionViewCell() }
            guard let challenge = self.challenge, let funFact = challenge.funFact else { return UICollectionViewCell() }
            cell.delegate = self
            cell.fill(with: funFact)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
}

// MARK: - DetailChallengeViewController+UICollectionViewDelegate
extension DetailChallengeViewController: UICollectionViewDelegate {
    
}

// MARK: - DetailChallengeViewController+DetailChallengeActionCollectionCellDelegate
extension DetailChallengeViewController: DetailChallengeActionCollectionCellDelegate {
    
    func detailChallengeActionCollectionCell(
        _ cell: DetailChallengeActionCollectionCell,
        didTap joinChallengeButton: UIButton
    ) {
        if let currentUserId = self.currentUser?.id, let connectedUserId = currentUser?.connectedUserId {
            let datePickerId = UUID().uuidString
            MessageKit.showDatePickerView(
                withId: datePickerId
            ) { selectedDate in
                MessageKit.hide(id: datePickerId)
                MessageKit.showLoadingView()
                guard var newChallenge = self.challenge else { return }
                newChallenge.dueDate = selectedDate
                newChallenge.isActive = true
                newChallenge.addedDate = Date()
                let request = SaveUserChallengeUseCaseRequest(
                    currentUserId: currentUserId,
                    connectedUserId: connectedUserId,
                    challenge: newChallenge
                )
                self.useCase.saveUserChallengeUseCase().execute(request) { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            MessageKit.hideLoadingView()
                            MessageKit.showAlertMessageView(title: "New challenge has been added.", type: .success)
                            let notification = NotificationDomain(
                                notificationType: .challengeRequest,
                                title: "You got new challenge",
                                message: "new challenge have been added to your current challenge.",
                                challengeId: request.challenge.id,
                                date: Date(),
                                senderId: currentUserId,
                                receiverId: connectedUserId
                            )
                            self.useCase.saveNotificationUseCase().execute(SaveNotificationUseCaseRequest(notification: notification)) { _ in }
                            guard let savedChallenge = response.challenge else { return }
                            self.challenge = savedChallenge
                        }
                    case .failure:
                        DispatchQueue.main.async {
                            MessageKit.hideLoadingView()
                            MessageKit.showAlertMessageView(title: "Unable to perform request, please check your internet connection.", type: .failure)
                        }
                    }
                }
            } dismissAction: {
                MessageKit.hide(id: datePickerId)
            }
        } else {
            let messageViewId = UUID().uuidString
            MessageKit.showConnectWithWifeAlert(withId: messageViewId, duration: .forever) {
                guard let tabBarController = self.tabBarController, let viewControllersCount = tabBarController.viewControllers?.count  else { return }
                self.tabBarController?.selectedIndex = viewControllersCount - 1
                MessageKit.hide(id: messageViewId)
            }
        }
    }
    
    
}


// MARK: - DetailChallengeViewController+DetailChallengeStepCollectionCellDelegate
extension DetailChallengeViewController: DetailChallengeStepCollectionCellDelegate {
    
    func detailChallengeStepCollectionCell(
        _ cell: DetailChallengeStepCollectionCell,
        didTap checkMarkButton: UIButton,
        withStep step: ChallengeStepDomain
    ) {
        guard var challenge = self.challenge, let stepIndex = challenge.steps.firstIndex(where: {$0.id == step.id}) else { return }
        challenge.steps[stepIndex].isDone = !challenge.steps[stepIndex].isDone
        self.challenge?.steps[stepIndex].isDone = challenge.steps[stepIndex].isDone
        if !challenge.steps.contains(where: {$0.isDone == false}) {
            challenge.isCompleted = true
            self.showCompletedChallengeMessage()
        } else {
            challenge.isCompleted = false
        }
        self.challenge?.isCompleted = challenge.isCompleted
        self.saveChallenge { _ in }
        guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
        self.collectionView.performBatchUpdates {
            self.collectionView.reloadItems(at: [indexPath])
        }
    }

}

extension DetailChallengeViewController: DetailChallengeFunFactCollectionCellDelegate {
    
    func detailChallengeFunFactCollectionCell(
        _ cell: DetailChallengeFunFactCollectionCell,
        didTap resourceLinkButton: UIButton
    ) {
        
        guard let challenge = self.challenge, let funcFactUrl = challenge.funFact?.url, let url = URL(string: funcFactUrl),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, completionHandler: nil)
    }

}

extension DetailChallengeViewController: DetailChallengeCollectionHeaderViewDelegate {
    
    func detailChallengeCollectionHeaderView(_ view: UICollectionViewCell, didTapSaveButton button: UIButton) {
        if let currentUser = self.currentUser, currentUser.connectedUserId == nil  {
            let messageViewId = UUID().uuidString
            MessageKit.showConnectWithWifeAlert(withId: messageViewId, duration: .forever) {
                guard let tabBarController = self.tabBarController, let viewControllersCount = tabBarController.viewControllers?.count  else { return }
                self.tabBarController?.selectedIndex = viewControllersCount - 1
                MessageKit.hide(id: messageViewId)
            }
        } else {
            if let isActive = self.challenge?.isActive, !isActive {
                MessageKit.showLoadingView()
                self.challenge?.addedDate =  Date()
                self.saveChallenge { savedChallenge in
                    MessageKit.hideLoadingView()
                    self.challenge = savedChallenge
                    MessageKit.showAlertMessageView(title: "Challenge has been saved.", type: .success)
                }
            }
        }
    }
    
}

extension DetailChallengeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        MessageKit.showLoadingView()
        guard let image = info[.editedImage] as? UIImage else { return }
        self.challenge?.momentImage = image
        self.saveChallenge { _ in
            MessageKit.hideLoadingView()
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}
