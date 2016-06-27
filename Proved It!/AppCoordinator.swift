//
//  AppCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol CoordinatorType {
    func start()
}

final class AppCoordinator: CoordinatorType {
    private let navigationController: UINavigationController
    private let managedObjectContext: NSManagedObjectContext
    private var childCoordinators: [CoordinatorType] = []

    init(withNavigationController navigationController: UINavigationController, managedObjectContext: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.managedObjectContext = managedObjectContext
    }

    func start() {
        if shouldStartOnboardingCoordinator() {
            startOnboardingCoordinator()
        }
    }

    private func shouldStartOnboardingCoordinator() -> Bool {
        return true
    }

    private func startOnboardingCoordinator() {
        let onboardingCoordinator = OnboardingCoordinator(withNavigationController: navigationController, managedObjectContext: managedObjectContext)
        onboardingCoordinator.start()

        childCoordinators.append(onboardingCoordinator)
    }
}
