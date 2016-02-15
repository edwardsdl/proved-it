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
    private var childCoordinators: [CoordinatorType] = []
    private let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        let onboardingCoordinator = OnboardingCoordinator(withNavigationController: navigationController)
        onboardingCoordinator.start()

        childCoordinators.append(onboardingCoordinator)
    }
}
