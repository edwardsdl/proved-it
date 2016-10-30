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
    func onboardingCoordinator(_ onboardingCoordinator: OnboardingCoordinator, didFinishWith user: User)
}

final class OnboardingCoordinator: CoordinatorType {
    weak var delegate: OnboardingCoordinatorDelegate?
    
    fileprivate let navigationController: UINavigationController
    fileprivate let managedObjectContext: NSManagedObjectContext
    
    fileprivate var childCoordinators: [CoordinatorType]

    init(with navigationController: UINavigationController, managedObjectContext: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.managedObjectContext = managedObjectContext
        self.childCoordinators = []
    }

    func start() {
        let introductionViewController = IntroductionViewController()
        introductionViewController.delegate = self

        navigationController.viewControllers = [introductionViewController]
    }
    
    fileprivate func startAuthenticationCoordinator() {
        let authenticationCoordinator = AuthenticationCoordinator(with: navigationController, managedObjectContext: managedObjectContext)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        
        childCoordinators.append(authenticationCoordinator)
    }
    
    fileprivate func startErrorCoordinator(with error: Error) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
    }
}

extension OnboardingCoordinator: IntroductionViewControllerDelegate {
    func introductionViewControllerDidTapProveItButton(_ introductionViewController: IntroductionViewController) {
        startAuthenticationCoordinator()
    }
}

extension OnboardingCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User) {
        let enterNameViewController = EnterNameViewController()
        enterNameViewController.delegate = self
        enterNameViewController.configure(with: user)
        
        navigationController.isNavigationBarHidden = false
        navigationController.pushViewController(enterNameViewController, animated: true)
        
        childCoordinators.remove(predicate: { $0 === authenticationCoordinator })
    }
    
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewController(_ enterNameViewController: EnterNameViewController, didFinishWith user: User) {
        let chooseTimeViewController = ChooseTimeViewController()
        chooseTimeViewController.delegate = self
        chooseTimeViewController.configure(with: user, isOnboarding: true)
        
        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
    
    func enterNameViewController(_ enterNameViewController: EnterNameViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didFinishWith user: User) {
        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController()
        chooseSignificantOtherViewController.delegate = self
        chooseSignificantOtherViewController.configure(with: user)
        
        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
    
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User) {
        delegate?.onboardingCoordinator(self, didFinishWith: user)
    }
    
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(_ errorCoordinator: ErrorCoordinator) {        
        childCoordinators.remove(predicate: { $0 === errorCoordinator })
    }
}
