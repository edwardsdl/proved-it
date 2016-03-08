//
//  AppCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol CoordinatorType {
    func start()
}

final class AppCoordinator: CoordinatorType {
    private let navigationController: UINavigationController
    private let coreDataStore: CoreDataStoreType
    private var childCoordinators: [CoordinatorType] = []

    init(withNavigationController navigationController: UINavigationController, coreDataStore: CoreDataStoreType) {
        self.navigationController = navigationController
        self.coreDataStore = coreDataStore
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
        let onboardingCoordinator = OnboardingCoordinator(withNavigationController: navigationController, coreDataStore: coreDataStore)
        onboardingCoordinator.start()

        childCoordinators.append(onboardingCoordinator)
    }
}
