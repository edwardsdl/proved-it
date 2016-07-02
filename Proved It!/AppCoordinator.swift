//
//  AppCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol CoordinatorType: class {

}

final class AppCoordinator: CoordinatorType {
    private let navigationController: UINavigationController
    
    private var childCoordinators: [CoordinatorType]
    private var managedObjectContext: NSManagedObjectContext?

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    func start(with managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        let introductionViewController = createIntroductionViewController()
        
        configureNavigationController(with: introductionViewController)
    }
    
    func start(with error: ErrorType) {
        startErrorCoordinator(with: error)
    }
    
    private func createIntroductionViewController() -> IntroductionViewController {
        let introductionViewController = IntroductionViewController()
        introductionViewController.delegate = self
        
        return introductionViewController
    }
    
    private func configureNavigationController(with introductionViewController: IntroductionViewController) {
        navigationController.navigationBarHidden = true
        navigationController.viewControllers = [introductionViewController]
    }
    
    private func startErrorCoordinator(with error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
}

extension AppCoordinator: IntroductionViewControllerDelegate {
    func introductionViewControllerDidTapProveItButton(introductionViewController: IntroductionViewController) {
        guard let managedObjectContext = managedObjectContext else {
            return
        }
        
        let authenticationCoordinator = AuthenticationCoordinator(with: navigationController, managedObjectContext: managedObjectContext)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        
        childCoordinators.append(authenticationCoordinator)
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User) {
        if shouldStartOnboardingCoordinator(with: user) {
            startOnboardingCoordinator(with: user)
        } else {
            startDashboardCoordinator(with: user)
        }
    }
    
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
    
    private func shouldStartOnboardingCoordinator(with user: User) -> Bool {
        return user.name == nil
    }
    
    private func startOnboardingCoordinator(with user: User) {
        let onboardingCoordinator = OnboardingCoordinator(with: navigationController, user: user)
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
        
        childCoordinators.append(onboardingCoordinator)
    }
    
    private func startDashboardCoordinator(with user: User) {
        let dashboardCoordinator = DashboardCoordinator(with: navigationController, user: user)
        dashboardCoordinator.start()
        
        childCoordinators.append(dashboardCoordinator)
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinator(onboardingCoordinator: OnboardingCoordinator, didFinishWith user: User) {
        startDashboardCoordinator(with: user)
        
        childCoordinators.remove({ $0 === onboardingCoordinator })
    }
}

extension AppCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
