//
//  OnboardingCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class OnboardingCoordinator: CoordinatorType {
    private let navigationController: UINavigationController
    private let coreDataStore: CoreDataStack
    private var childCoordinators: [CoordinatorType] = []

    init(withNavigationController navigationController: UINavigationController, coreDataStore: CoreDataStoreType) {
        self.navigationController = navigationController
        self.coreDataStore = coreDataStore
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
        let enterNameViewController = EnterNameViewController(withCoreDataStore: coreDataStore)
        enterNameViewController.delegate = self

        navigationController.pushViewController(enterNameViewController, animated: true)
    }

    func authenticationCoordinatorDidFailAuthentication(authenticationCoordinator: AuthenticationCoordinator) {

    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User) {
        let chooseTimeViewController = ChooseTimeViewController(withCoreDataStore: coreDataStore, user: user)
        chooseTimeViewController.delegate = self

        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
}

extension OnboardingCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWithUser user: User) {

    }
}

extension OnboardingCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(chooseSignificantotherViewController: ChooseSignificantOtherViewController, didFinishWithUser user: User) {
        
    }
}
