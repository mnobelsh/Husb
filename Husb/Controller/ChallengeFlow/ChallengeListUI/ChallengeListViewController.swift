//
//  ChallengeListViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit

struct ChallengeListViewControllerRequest {
    
    enum PageType {
        case loveLanguage(LoveLanguageDomain)
        case saved([ChallengeDomain])
        case tips([TipsDomain])
    }
    
    let forType: PageType
}

protocol ChallengeListViewControllerRoute {
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    )
    
}

class ChallengeListViewController: UIViewController {
    
    
    static func create(
        route: ChallengeListViewControllerRoute,
        request: ChallengeListViewControllerRequest
    ) -> ChallengeListViewController {
        let viewController = ChallengeListViewController()
        viewController.route = route
        viewController.request = request
        return viewController
    }
    
    private var route: ChallengeListViewControllerRoute!
    private var request: ChallengeListViewControllerRequest!
    
    private var challenges: [ChallengeDomain] = []
    private var tips: [TipsDomain] = []
    
    // MARK: - SubViews
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .funYellow
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        view.heroID = "HeaderContainerView"
        view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(50)
            make.trailing.greaterThanOrEqualToSuperview().offset(-20)
            make.leading.greaterThanOrEqualToSuperview().offset(65)
            make.bottom.equalToSuperview().offset(-20)
        }
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.6
        label.textColor = .jetBlack
        label.textAlignment = .center
        return label
    }()
    lazy var collectionView: ChallengeListCollectionView = ChallengeListCollectionView(frame: self.view.frame)
    
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


// MARK: - Private Functions
private extension ChallengeListViewController {
    
    func setupViewDidLoad() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.headerView)
        self.headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        self.collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
            
        }
        self.configureBackButton(with: .chevronLeft)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        self.activateTapViewEndEditingWithGesture()
        
        switch self.request.forType {
        case .saved(let challenges):
            self.titleLabel.text = "Saved Challenges"
            self.challenges = challenges
        case .loveLanguage(let loveLanguage):
            self.titleLabel.text = loveLanguage.title
            switch loveLanguage.type {
            case .actOfService:
                self.challenges = ChallengeDomain.actOfService
            case .givingGifts:
                self.challenges = ChallengeDomain.givingGifts
            case .physicalTouch:
                self.challenges = ChallengeDomain.physicalTouch
            case .qualityTime:
                self.challenges = ChallengeDomain.qualityTime
            case .wordsOfAffirmation:
                self.challenges = ChallengeDomain.wordsOfAffirmation
            }
        case .tips(let tips):
            self.tips = tips
            self.titleLabel.text = "Tips"
        }
        
        self.collectionView.contentInset = .init(top: 20, left: 20, bottom: 120, right: 20)
        self.collectionView.reloadData()
    }
    
}

// MARK: - ChallengeListViewController+UICollectionViewDataSource
extension ChallengeListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.request.forType {
        case .loveLanguage,.saved:
            return self.challenges.count
        case .tips:
            return self.tips.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.request.forType {
        case .loveLanguage,.saved:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
            cell.fill(challenge: self.challenges[indexPath.row])
            return cell
        case .tips:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsCollectionCell.identifier, for: indexPath) as? TipsCollectionCell else { return UICollectionViewCell() }
            cell.fill(tips: self.tips[indexPath.row])
            return cell
        }
    }

}

// MARK: - ChallengeListViewController+UICollectionViewDelegate
extension ChallengeListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.request.forType {
        case .loveLanguage,.saved:
            self.route.showDetailChallengeUI(
                navigationController: self.navigationController,
                request: .init(challenge: self.challenges[indexPath.row])
            )
        default:
            break
        }
    }
    
}

// MARK: - ChallengeListViewController+UICollectionViewDelegateFlowLayout
extension ChallengeListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.width*0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
