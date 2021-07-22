//
//  AppDIContainer.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit

typealias ViewControllerRoute =
    OnBoardingViewControllerRoute &
    SignInViewControllerRoute &
    SignUpViewControllerRoute &
    LaunchPadViewControllerRoute &
    DashboardChallengeViewControllerRoute &
    DashboardExploreViewControllerRoute &
    DashboardCalendarViewControllerRoute &
    DashboardNotificationViewControllerRoute &
    DashboardProfileViewControllerRoute &
    DetailChallengeViewControllerRoute &
    ChallengeListViewControllerRoute &
    ExploreSearchViewControllerRoute &
    MessageFromWifeNotificationViewControllerRoute &
    ChallengeRequestNotificationViewControllerRoute &
    ConnectProfileViewControllerRoute &
    CompletedChallengeNotificationViewControllerRoute


enum AppInstructor {
    case onBoarding
    case mainApp
    case auth
}

class AppDIContainer {
    
    let navigationController: UINavigationController
    let userDefaultStorage = UserDefaultStorage.shared
    static let shared = AppDIContainer(navigationController: SceneDelegate.navigationController)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(instructor: AppInstructor) {
        switch instructor {
        case .mainApp:
            self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController.pushViewController(
                self.makeLaunchPadViewController(request: .init()),
                animated: true
            )
        case .onBoarding:
            self.navigationController.pushViewController(
                self.makeOnBoardingViewController(),
                animated: true
            )
        case .auth:
            self.navigationController.pushViewController(
                self.makeSignInViewController(),
                animated: true
            )
        }
    }
    
    private func makeSignInViewController() -> SignInViewController {
        let request = SignInViewControllerRequest()
        return SignInViewController.create(route: self, request: request, useCase: self)
    }
    
    private func makeLaunchPadViewController(
        request: LaunchPadViewControllerRequest
    ) -> LaunchPadViewController {
        return LaunchPadViewController.create(route: self, request: request)
    }
    
    private func makeOnBoardingViewController() -> OnBoardingViewController {
        let firstOnBoardingVC = FirstOnBoardingViewController()
        let secondOnBoardingVC = SecondOnBoardingViewController()
        let thirdOnBoardingVC = ThirdOnBoardingViewController()
        thirdOnBoardingVC.route = self
        thirdOnBoardingVC.useCase = self
        
        return OnBoardingViewController.create(
            route: self,
            request: .init(
                firstOnBoardingViewController: firstOnBoardingVC,
                secondOnBoardingViewController: secondOnBoardingVC,
                thirdOnBoardingViewController: thirdOnBoardingVC
            ),
            useCase: self
        )
    }
    
}
