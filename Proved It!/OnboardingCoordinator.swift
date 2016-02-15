//
//  OnboardingCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class OnboardingCoordinator: CoordinatorType, IntroductionViewControllerDelegate, AuthenticationCoordinatorDelegate {
    private var childCoordinators: [CoordinatorType] = []
    private let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let introductionViewController = IntroductionViewController()
        introductionViewController.delegate = self

        navigationController.navigationBarHidden = true
        navigationController.viewControllers = [introductionViewController]
    }

    func introductionViewControllerDidTapProveItButton(introductionViewController: IntroductionViewController) {
        let authenticationCoordinator = AuthenticationCoordinator(withNavigationController: navigationController)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()

        childCoordinators.append(authenticationCoordinator)
    }

    func authenticationCoordinatorDidPassAuthentication(authenticationCoordinator: AuthenticationCoordinator) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.blueColor()

        navigationController.viewControllers.append(viewController)
    }

    func authenticationCoordinatorDidFailAuthentication(authenticationCoordinator: AuthenticationCoordinator) {
        
    }
}
