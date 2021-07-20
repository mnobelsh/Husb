//
//  LaunchPadViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

struct LaunchPadViewControllerRequest {

}

protocol LaunchPadViewControllerRoute {
    func makeExploreFlow() -> UINavigationController
    func makeChallengeFlow(request: DashboardChallengeViewControllerRequest) -> UINavigationController
    func makeCalendarFlow() -> UINavigationController
    func makeProfileFlow(request: DashboardProfileViewControllerRequest) -> UINavigationController
    func makeNotificationFlow() -> UINavigationController
}

class LaunchPadViewController: UITabBarController {
    
    private var route: LaunchPadViewControllerRoute!
    private var request: LaunchPadViewControllerRequest!
    
    static func create(
        route: LaunchPadViewControllerRoute,
        request: LaunchPadViewControllerRequest
    ) -> LaunchPadViewController {
        let viewController = LaunchPadViewController()
        viewController.route = route
        viewController.request = request
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
    
    // MARK: - Private Function
    private func setupViewDidLoad() {
        self.view.backgroundColor = .ghostWhite
        self.tabBar.barTintColor = .pearlWhite
    }
    
    private func setupViewWillAppear() {
        self.viewControllers = [
            self.route.makeChallengeFlow(request: .init()),
            self.route.makeExploreFlow(),
            self.route.makeCalendarFlow(),
            self.route.makeNotificationFlow(),
            self.route.makeProfileFlow(request: .init())
        ]
    }
    
}

