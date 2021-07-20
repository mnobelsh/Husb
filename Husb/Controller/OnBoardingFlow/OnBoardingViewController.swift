//
//  OnBoardingViewController.swift
//  Husb
//
//  Created by Muhammad Nobel Shidqi on 12/06/21.
//

import UIKit
import CoreData

struct OnBoardingViewControllerRequest {
    let firstOnBoardingViewController: FirstOnBoardingViewController
    let secondOnBoardingViewController: SecondOnBoardingViewController
    let thirdOnBoardingViewController: ThirdOnBoardingViewController
}

protocol OnBoardingViewControllerRoute {
    
    func showSignInUI(
        navigationController: UINavigationController?,
        request: SignInViewControllerRequest
    )
    
}

class OnBoardingViewController: UIPageViewController {
    
    private var route: OnBoardingViewControllerRoute!
    private var request: OnBoardingViewControllerRequest!
    private var useCase: UseCaseFactory!
    
    
    static func create(
        route: OnBoardingViewControllerRoute,
        request: OnBoardingViewControllerRequest,
        useCase: UseCaseFactory
    ) -> OnBoardingViewController {
        let viewController = OnBoardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        viewController.route = route
        viewController.request = request
        viewController.useCase = useCase
        return viewController
    }
    
    lazy var onBoardingViewControllers = [
        self.request.firstOnBoardingViewController,
        self.request.secondOnBoardingViewController,
        self.request.thirdOnBoardingViewController
    ]
    var currentIndex = 0
    
    // MARK: - SubViews
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .init(x: 0, y: 0, width: 100, height: 45))
        pageControl.tintColor = .darkGray
        pageControl.pageIndicatorTintColor = .darkGray
        pageControl.backgroundColor = .clear
        pageControl.currentPageIndicatorTintColor = .jetBlack
        pageControl.currentPage = 0
        pageControl.numberOfPages = self.onBoardingViewControllers.count
        return pageControl
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


private extension OnBoardingViewController {
    
    func setupViewDidLoad() {
        self.view.backgroundColor = .ghostWhite
        self.delegate = self
        self.dataSource = self
        self.setViewControllers([self.request.firstOnBoardingViewController], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(self.pageControl)
        
        self.pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(30)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
}

extension OnBoardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.onBoardingViewControllers.indexOf(viewController) else { return nil }
        if self.currentIndex != 0 {
            self.currentIndex -= 1
        }
        let previousIndex = viewControllerIndex - 1
        pageControl.currentPage = viewControllerIndex
        guard previousIndex >= 0 && self.onBoardingViewControllers.count > previousIndex else {
            return nil
        }
        return self.onBoardingViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.onBoardingViewControllers.indexOf(viewController) else { return nil }
        self.currentIndex += 1
        let nextIndex = viewControllerIndex + 1
        pageControl.currentPage = viewControllerIndex
        guard self.onBoardingViewControllers.count != nextIndex && self.onBoardingViewControllers.count > nextIndex  else {
            return nil
        }
        return self.onBoardingViewControllers[nextIndex]
    }
    
    
}

extension OnBoardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
    }
    
}
