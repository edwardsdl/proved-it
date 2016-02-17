//
//  OnboardingCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class OnboardingCoordinator: CoordinatorType {
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
}

extension OnboardingCoordinator: IntroductionViewControllerDelegate {
    func introductionViewControllerDidTapProveItButton(introductionViewController: IntroductionViewController) {
        let authenticationCoordinator = AuthenticationCoordinator(withNavigationController: navigationController)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()

        childCoordinators.append(authenticationCoordinator)
    }
}

extension OnboardingCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinatorDidPassAuthentication(authenticationCoordinator: AuthenticationCoordinator) {
        let enterNameViewController = EnterNameViewController()
        enterNameViewController.delegate = self

        navigationController.pushViewController(enterNameViewController, animated: true)
    }

    func authenticationCoordinatorDidFailAuthentication(authenticationCoordinator: AuthenticationCoordinator) {

    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewControllerDidEnterName(enterNameViewController: EnterNameViewController) {
        let chooseTimeViewController = ChooseTimeViewController()

        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
}
