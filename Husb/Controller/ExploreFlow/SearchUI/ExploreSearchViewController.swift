//
//  ExploreSearchViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 03/07/21.
//

import UIKit

struct ExploreSearchViewControllerRequest {
    
}

protocol ExploreSearchViewControllerRoute {
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    )
    
}


class ExploreSearchViewController: UIViewController {
    
    static func create(
        route: ExploreSearchViewControllerRoute,
        request: ExploreSearchViewControllerRequest,
        useCase: UseCaseFactory
    ) -> ExploreSearchViewController {
        let viewController = ExploreSearchViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    private var route: ExploreSearchViewControllerRoute!
    private var request: ExploreSearchViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    private lazy var challenges: [ChallengeDomain] = self.challengesResult
    private var challengesResult: [ChallengeDomain] = ChallengeDomain.allChallenges {
        didSet {
            self.searchCollectionView.performBatchUpdates {
                self.searchCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
    // MARK: - SubViews
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .funYellow
        view.heroID = "HeaderHero"
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        return view
    }()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocorrectionType = .no
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .search
        searchBar.searchTextField.textColor = .jetBlack
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search with love", attributes: [
            .foregroundColor: UIColor.spaceGrey,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .pearlWhite
        searchBar.searchTextField.layer.shadowOffset = .init(width: 1.5, height: 1.5)
        searchBar.searchTextField.layer.shadowColor = UIColor.spaceGrey.cgColor
        searchBar.searchTextField.layer.shadowOpacity = 1
        searchBar.delegate = self
        return searchBar
    }()
    private lazy var searchCollectionView: ChallengeListCollectionView = ChallengeListCollectionView(frame: self.view.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.enableHero()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.disableHero()
    }
    
}

// MARK: - Private Functions
private extension ExploreSearchViewController {
    
    func setupViewDidLoad(){
        self.searchCollectionView.delegate = self
        self.searchCollectionView.dataSource = self
        self.view.backgroundColor = .ghostWhite
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.searchCollectionView)
        self.searchBar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalTo(self.headerView).offset(20)
        }
        self.headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        self.searchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.configureBackButton(with: .chevronDown)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        self.activateTapViewEndEditingWithGesture()
    }
    
}

// MARK: - ExploreSearchViewController+UISearchBarDelegate
extension ExploreSearchViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty || searchText.isEmpty {
            self.challengesResult = self.challenges
        } else {
            self.challengesResult = self.challenges.filter({$0.title.lowercased().contains(searchText.lowercased())})
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

// MARK: - ExploreSearchViewController+UICollectionViewDataSource
extension ExploreSearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.challengesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DefaultChallengeCollectionCell.identifier, for: indexPath) as? DefaultChallengeCollectionCell else { return UICollectionViewCell() }
        cell.fill(challenge: self.challengesResult[indexPath.row])
        return cell
    }
    
}


// MARK: - ExploreSearchViewController+UICollectionViewDelegate
extension ExploreSearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.route.showDetailChallengeUI(
            navigationController: self.navigationController,
            request: .init(challenge: self.challengesResult[indexPath.row])
        )
    }
    
}


// MARK: - ExploreSearchViewController+UICollectionViewDelegateFlowLayout
extension ExploreSearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 50, height: self.view.frame.width*0.45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
