//
//  OnboardingCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol OnboardingCoordinatorDelegate: class {
    func onboardingCoordinator(onboardingCoordinator: OnboardingCoordinator, didFinishWith user: User)
}

final class OnboardingCoordinator: CoordinatorType {
    weak var delegate: OnboardingCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let user: User
    private let originalViewController: UIViewController?
    
    private var childCoordinators: [CoordinatorType]

    init(with navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
        self.originalViewController = navigationController.topViewController
        self.childCoordinators = []
    }

    func start() {
        let enterNameViewController = EnterNameViewController(with: user)
        enterNameViewController.delegate = self
        
        navigationController.pushViewController(enterNameViewController, animated: true)
    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didEncounter error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
    }
    
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWithUser user: User) {
        let chooseTimeViewController = ChooseTimeViewController(with: user)
        chooseTimeViewController.delegate = self

        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
}

extension OnboardingCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWithUser user: User) {
        delegate?.onboardingCoordinator(self, didFinishWith: user)
        
//        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController(with: user)
//        chooseTimeViewController.delegate = self
//        
//        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
}

extension OnboardingCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(chooseSignificantotherViewController: ChooseSignificantOtherViewController, didFinishWithUser user: User) {
        if let originalViewController = originalViewController {
            navigationController.popToViewController(originalViewController, animated: false)
        }
        
        delegate?.onboardingCoordinator(self, didFinishWith: user)
    }
}

extension OnboardingCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {        
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
