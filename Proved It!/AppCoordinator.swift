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
    private var childCoordinators: [CoordinatorType] = []

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(with managedObjectContext: NSManagedObjectContext) {
        if shouldStartOnboardingCoordinator() {
            startOnboardingCoordinator(with: managedObjectContext)
        } else {
            startDashboardCoordinator(with: managedObjectContext)
        }
    }
    
    func start(with error: ErrorType) {
        startErrorCoordinator(with: error)
    }
    
    private func shouldStartOnboardingCoordinator() -> Bool {
        return true
    }

    private func startErrorCoordinator(with error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
    
    private func startOnboardingCoordinator(with managedObjectContext: NSManagedObjectContext) {
        let onboardingCoordinator = OnboardingCoordinator(withNavigationController: navigationController, managedObjectContext: managedObjectContext)
        onboardingCoordinator.start()

        childCoordinators.append(onboardingCoordinator)
    }
    
    private func startDashboardCoordinator(with managedObjectContext: NSManagedObjectContext) {
        // TODO: Add implementation
    }
}

extension AppCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove({ $0 === errorCoordinator })
    }
}
