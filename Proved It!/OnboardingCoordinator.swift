//
//  OnboardingCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

final class OnboardingCoordinator: CoordinatorType {
    private let navigationController: UINavigationController
    private let managedObjectContext: NSManagedObjectContext
    
    private var childCoordinators: [CoordinatorType]
    private var user: User?

    init(withNavigationController navigationController: UINavigationController, managedObjectContext: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.managedObjectContext = managedObjectContext
        self.childCoordinators = []
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
        let enterNameViewController = EnterNameViewController(withManagedObjectContext: managedObjectContext)
        enterNameViewController.delegate = self

        navigationController.pushViewController(enterNameViewController, animated: true)
    }

    func authenticationCoordinatorDidFailAuthentication(authenticationCoordinator: AuthenticationCoordinator) {

    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didEncounter error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
    }
    
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User) {
        let chooseTimeViewController = ChooseTimeViewController(withManagedObjectContext: managedObjectContext, user: user)
        chooseTimeViewController.delegate = self

        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
}

extension OnboardingCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWithUser user: User) {
        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController()
        chooseTimeViewController.delegate = self
        
        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
}

extension OnboardingCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(chooseSignificantotherViewController: ChooseSignificantOtherViewController, didFinishWithUser user: User) {
        
    }
}

extension OnboardingCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {        
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
