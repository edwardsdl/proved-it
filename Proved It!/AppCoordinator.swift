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
        
        navigationController.navigationBarHidden = true
        navigationController.viewControllers = [LoadingViewController()]
        
        if shouldStartAuthenticationCoordinator() {
            startAuthenticationCoordinator()
        } else {
            startOnboardingCoordinator()
        }
    }
    
    func start(with error: ErrorType) {
        startErrorCoordinator(with: error)
    }
    
    private func shouldStartAuthenticationCoordinator() -> Bool {
        return NSUserDefaults.standardUserDefaults().boolForKey(Constants.UserDefaults.HasLoggedInKey)
    }

    private func startAuthenticationCoordinator() {
        guard let managedObjectContext = managedObjectContext else {
            startErrorCoordinator(with: ApplicationError.FailedToUnwrapValue)
            
            return
        }
        
        let authenticationCoordinator = AuthenticationCoordinator(with: self.navigationController, managedObjectContext: managedObjectContext)
        authenticationCoordinator.delegate = self
        authenticationCoordinator.start()
        
        childCoordinators.append(authenticationCoordinator)
    }
    
    private func startOnboardingCoordinator() {
        guard let managedObjectContext = managedObjectContext else {
            startErrorCoordinator(with: ApplicationError.FailedToUnwrapValue)
            
            return
        }
        
        let onboardingCoordinator = OnboardingCoordinator(with: navigationController, managedObjectContext: managedObjectContext)
        onboardingCoordinator.delegate = self
        onboardingCoordinator.start()
        
        childCoordinators.append(onboardingCoordinator)
    }
    
    private func startErrorCoordinator(with error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
    
    private func startDashboardCoordinator(with user: User) {
        let dashboardCoordinator = DashboardCoordinator(with: navigationController, user: user)
        dashboardCoordinator.delegate = self
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

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User) {
        startDashboardCoordinator(with: user)
        
        childCoordinators.remove({ $0 === authenticationCoordinator })
    }
    
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension AppCoordinator: DashboardCoordinatorDelegate {
    func dashboardCoordinatorDidTapSignOut(dashboardCoordinator: DashboardCoordinator) {
        navigationController.popViewControllerAnimated(true)
        
        startOnboardingCoordinator()
        
        childCoordinators.remove({ $0 === dashboardCoordinator })
    }
}

extension AppCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
