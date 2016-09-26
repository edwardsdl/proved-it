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
    fileprivate let navigationController: UINavigationController
    
    fileprivate var childCoordinators: [CoordinatorType]
    fileprivate var managedObjectContext: NSManagedObjectContext?

    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = []
    }

    func start(with managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [LoadingViewController()]
        
        if shouldStartAuthenticationCoordinator() {
            startAuthenticationCoordinator()
        } else {
            startOnboardingCoordinator()
        }
    }
    
    func start(with error: Error) {
        startErrorCoordinator(with: error)
    }
    
    fileprivate func shouldStartAuthenticationCoordinator() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.UserDefaults.HasLoggedInKey)
    }

    fileprivate func startAuthenticationCoordinator() {
        guard let managedObjectContext = managedObjectContext else {
            startErrorCoordinator(with: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        let authenticationCoordinator = AuthenticationCoordinator(with: self.navigationController, managedObjectContext: managedObjectContext)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        
        childCoordinators.append(authenticationCoordinator)
    }
    
    fileprivate func startOnboardingCoordinator() {
        guard let managedObjectContext = managedObjectContext else {
            startErrorCoordinator(with: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        let onboardingCoordinator = OnboardingCoordinator(with: navigationController, managedObjectContext: managedObjectContext)
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
        
        childCoordinators.append(onboardingCoordinator)
    }
    
    fileprivate func startErrorCoordinator(with error: Error) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
    
    fileprivate func startDashboardCoordinator(with user: User) {
        let dashboardCoordinator = DashboardCoordinator(with: navigationController, user: user)
        dashboardCoordinator.delegate = self
        dashboardCoordinator.start()
        
        childCoordinators.append(dashboardCoordinator)
    }
}

extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinator(_ onboardingCoordinator: OnboardingCoordinator, didFinishWith user: User) {
        startDashboardCoordinator(with: user)
        
        childCoordinators.remove(predicate: { $0 === onboardingCoordinator })
    }
}

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User) {
        startDashboardCoordinator(with: user)
        
        childCoordinators.remove(predicate: { $0 === authenticationCoordinator })
    }
    
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension AppCoordinator: DashboardCoordinatorDelegate {
    func dashboardCoordinatorDidTapSignOut(_ dashboardCoordinator: DashboardCoordinator) {
        navigationController.popViewController(animated: true)
        
        startOnboardingCoordinator()
        
        childCoordinators.remove(predicate: { $0 === dashboardCoordinator })
    }
}

extension AppCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(_ errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove(predicate: { $0 === errorCoordinator })
    }
}
