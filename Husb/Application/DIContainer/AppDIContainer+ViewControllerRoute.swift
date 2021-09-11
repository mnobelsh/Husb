//
//  AppDIContainer+ViewControllerRoute.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 26/06/21.
//

import UIKit
import Hero


extension AppDIContainer: ViewControllerRoute {
    
    func showDetailTipsUI(
        navigationController: UINavigationController?,
        request: TipsViewControllerRequest
    ) {
        let viewController = TipsViewController.create(route: self, request: request, useCase: self)
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .up), dismissing: .slide(direction: .down))
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showCompletedChallengeNotificationUI(
        navigationController: UINavigationController?,
        request: CompletedChallengeNotificationViewControllerRequest
    ) {
        let viewController = CompletedChallengeNotificationViewController.create(route: self, request: request, useCase: self)
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }

    func showDashboardProfileUI(
        navigationController: UINavigationController?,
        request: DashboardProfileViewControllerRequest
    ) {
        let viewController = DashboardProfileViewController.create(route: self, request: request, useCase: self)
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showChallengeListUI(
        navigationController: UINavigationController?,
        request: ChallengeListViewControllerRequest
    ) {
        let viewController = ChallengeListViewController.create(
            route: self,
            request: request
        )
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showDetailChallengeUI(
        navigationController: UINavigationController?,
        request: DetailChallengeViewControllerRequest
    ) {
        let viewController = DetailChallengeViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .up), dismissing: .slide(direction: .down))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showMessageFromWifeNotificationUI(
        navigationController: UINavigationController?,
        request: MessageFromWifeNotificationViewControllerRequest
    ) {
        let viewController = MessageFromWifeNotificationViewController.create(
            route: self,
            request: request
        )
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showChallengeRequestNotificationUI(
        navigationController: UINavigationController?,
        request: ChallengeRequestNotificationViewControllerRequest
    ) {
        let viewController = ChallengeRequestNotificationViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSignUpUI(
        navigationController: UINavigationController?,
        request: SignUpViewControllerRequest
    ) {
        let viewController = SignUpViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        navigationController?.hero.navigationAnimationType = .selectBy(presenting: .slide(direction: .left), dismissing: .slide(direction: .right))
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showSignInUI(
        navigationController: UINavigationController?,
        request: SignInViewControllerRequest
    ) {
        let viewController = SignInViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        navigationController?.hero.navigationAnimationType = .pull(direction: .up)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    func showExploreSearchUI(
        navigationController: UINavigationController?,
        request: ExploreSearchViewControllerRequest
    ) {
        let viewController = ExploreSearchViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        navigationController?.hero.navigationAnimationType = .fade
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func makeExploreFlow() -> UINavigationController {
        let viewController = DashboardExploreViewController.create(route: self, request: .init(), useCase: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .clear
        return navigationController
    }
    
    func makeChallengeFlow(
        request: DashboardChallengeViewControllerRequest
    ) -> UINavigationController {
        let viewController = DashboardChallengeViewController.create(
            route: self,
            request: request,
            useCase: self
        )
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .clear
        return navigationController
    }
    
    func makeCalendarFlow() -> UINavigationController {
        let viewController = DashboardCalendarViewController.create(route: self, request: .init(), useCase: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .clear
        return navigationController
    }
    
    func makeProfileFlow(
        request:  DashboardProfileViewControllerRequest
    ) -> UINavigationController {
        let viewController = DashboardProfileViewController.create(route: self, request: request, useCase: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .clear
        return navigationController
    }
    
    func makeNotificationFlow() -> UINavigationController {
        let viewController = DashboardNotificationViewController.create(route: self, request: .init(), useCase: self)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        navigationController.view.backgroundColor = .clear
        return navigationController
    }
    
    func makeConnectProfileViewController(
        request: ConnectProfileViewControllerRequest
    ) -> ConnectProfileViewController {
        return ConnectProfileViewController.create(route: self, request: request, useCase: self)
    }
    
    

}
