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
    private let managedObjectContext: NSManagedObjectContext
    
    private var childCoordinators: [CoordinatorType]

    init(with navigationController: UINavigationController, managedObjectContext: NSManagedObjectContext) {
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
    
    private func startAuthenticationCoordinator() {
        let authenticationCoordinator = AuthenticationCoordinator(with: navigationController, managedObjectContext: managedObjectContext)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        
        childCoordinators.append(authenticationCoordinator)
    }
    
    private func startErrorCoordinator(with error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
    }
}

extension OnboardingCoordinator: IntroductionViewControllerDelegate {
    func introductionViewControllerDidTapProveItButton(introductionViewController: IntroductionViewController) {
        startAuthenticationCoordinator()
    }
}

extension OnboardingCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User) {
        let enterNameViewController = EnterNameViewController(with: user)
        enterNameViewController.delegate = self
        
        navigationController.pushViewController(enterNameViewController, animated: true)
        
        childCoordinators.remove({ $0 === authenticationCoordinator })
    }
    
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: EnterNameViewControllerDelegate {
    func enterNameViewController(enterNameViewController: EnterNameViewController, didFinishWith user: User) {
        let chooseTimeViewController = ChooseTimeViewController(with: user)
        chooseTimeViewController.delegate = self
        
        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
    
    func enterNameViewController(enterNameViewController: EnterNameViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWith user: User) {
        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController(with: user)
        chooseSignificantOtherViewController.delegate = self
        
        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
    
    func chooseTimeNameViewController(chooseTimeViewController: ChooseTimeViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User) {
        navigationController.navigationBarHidden = false
        navigationController.viewControllers = []
        
        delegate?.onboardingCoordinator(self, didFinishWith: user)
    }
    
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension OnboardingCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {        
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
