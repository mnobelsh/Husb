//
//  TipsViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 11/09/21.
//

import UIKit

struct TipsViewControllerRequest {
    let tips: TipsDomain
}

protocol TipsViewControllerRoute {
    
    
}

class TipsViewController: UIPageViewController {
    
    private var route: TipsViewControllerRoute!
    private var request: TipsViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    
    static func create(
        route: TipsViewControllerRoute,
        request: TipsViewControllerRequest,
        useCase: UseCaseFactory
    ) -> TipsViewController {
        let viewController = TipsViewController()
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    

    
    // MARK: - SubViews
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.textColor = .jetBlack
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    private lazy var sourceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Source", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .clear
        button.setTitleColor(.seaBlue, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(self.onSourceButtonTouchUpInside(_:)), for: .touchUpInside)
        return button
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


private extension TipsViewController {
    
    func setupViewDidLoad() {
        self.configureBackButton(with: .chevronDown)
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.contentLabel)
        self.view.addSubview(self.sourceButton)
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(60)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(25)
        }
        
        self.sourceButton.snp.makeConstraints { make in
            make.leading.equalTo(self.titleLabel)
            make.top.equalTo(self.contentLabel.snp.bottom).offset(25)
        }
        
        self.titleLabel.text = self.request.tips.title
        self.contentLabel.text = self.request.tips.description
    }
    
    @objc
    func onSourceButtonTouchUpInside(_ sender: UIButton) {
        guard  let url = URL(string: self.request.tips.url),
              UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url, completionHandler: nil)
    }
    
}
