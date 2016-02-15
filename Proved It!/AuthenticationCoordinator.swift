//
//  AuthenticationCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import DigitsKit
import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func authenticationCoordinatorDidPassAuthentication(authenticationCoordinator: AuthenticationCoordinator)
    func authenticationCoordinatorDidFailAuthentication(authenticationCoordinator: AuthenticationCoordinator)
}

final class AuthenticationCoordinator: CoordinatorType {
    weak var delegate: AuthenticationCoordinatorDelegate?

    private var childCoordinators: [CoordinatorType] = []
    private let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let appearance = initializeAppearance()
        let authenticationConfiguration = initializeAuthenticationConfiguration(withAppearance: appearance)

        startDigitsAuthentication(withAuthenticationConfiguration: authenticationConfiguration)
    }

    private func initializeAppearance() -> DGTAppearance {
        let appearance = DGTAppearance()

        return appearance
    }

    private func initializeAuthenticationConfiguration(withAppearance appearance: DGTAppearance) -> DGTAuthenticationConfiguration {
        let authenticationConfiguration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
        authenticationConfiguration.appearance = appearance

        return authenticationConfiguration
    }

    private func startDigitsAuthentication(withAuthenticationConfiguration authenticationConfiguration: DGTAuthenticationConfiguration) {
        let digits = Digits.sharedInstance()
        digits.authenticateWithViewController(nil, configuration: authenticationConfiguration, completion: digitsAuthenticationCompleted)
    }

    private func digitsAuthenticationCompleted(session: DGTSession!, error: NSError!) {
        if session != nil {
            delegate?.authenticationCoordinatorDidPassAuthentication(self)
        } else {
            delegate?.authenticationCoordinatorDidFailAuthentication(self)
        }
    }
}
