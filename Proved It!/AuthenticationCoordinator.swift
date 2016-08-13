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
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User)
    func authenticationCoordinator(authenticationCoordinator: AuthenticationCoordinator, didEncounter error: ErrorType)
}

final class AuthenticationCoordinator: CoordinatorType {
    weak var delegate: AuthenticationCoordinatorDelegate?

    private let navigationController: UINavigationController
    private let managedObjectContext: NSManagedObjectContext
    
    private var childCoordinators: [CoordinatorType]

    init(with navigationController: UINavigationController, managedObjectContext: NSManagedObjectContext) {
        self.navigationController = navigationController
        self.managedObjectContext = managedObjectContext
        self.childCoordinators = []
    }

    func start() {
        let appearance = createAppearance()
        let authenticationConfiguration = createAuthenticationConfiguration(with: appearance)

        startDigitsAuthentication(with: authenticationConfiguration)
    }
}

private extension AuthenticationCoordinator {
    private func createAppearance() -> DGTAppearance {
        return DGTAppearance()
    }

    private func createAuthenticationConfiguration(with appearance: DGTAppearance) -> DGTAuthenticationConfiguration {
        let authenticationConfiguration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
        authenticationConfiguration.appearance = appearance

        return authenticationConfiguration
    }

    private func startDigitsAuthentication(with authenticationConfiguration: DGTAuthenticationConfiguration) {
        // Calling authenticateWithViewController too quickly after application:didFinishLaunchingWithOptions: causes
        // Digits to behave in unexpected ways. Wrapping the call in dispatch_after appears to be an effective workaround.
        dispatch_after(DISPATCH_TIME_NOW, dispatch_get_main_queue(), { [unowned self] in
            let digits = Digits.sharedInstance()
            digits.authenticateWithViewController(nil, configuration: authenticationConfiguration, completion: self.digitsAuthenticationCompleted)
        })
    }

    private func digitsAuthenticationCompleted(session: DGTSession!, error: NSError!) {
        guard session != nil else {
            delegate?.authenticationCoordinator(self, didEncounter: error)
            
            return
        }
        
        managedObjectContext.fetchUser(with: session.phoneNumber, completionHandler: { [unowned self] either in
            switch either {
            case .Left(let user):
                let user = user ?? User(insertedInto: self.managedObjectContext)
                user.phoneNumber = session.phoneNumber
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: Constants.UserDefaults.HasLoggedInKey)
                
                self.delegate?.authenticationCoordinator(self, didFinishWith: user)
            case .Right(let error):
                self.delegate?.authenticationCoordinator(self, didEncounter: error)
            }
        })
    }
}
