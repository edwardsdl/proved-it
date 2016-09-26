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
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didFinishWith user: User)
    func authenticationCoordinator(_ authenticationCoordinator: AuthenticationCoordinator, didEncounter error: Error)
}

final class AuthenticationCoordinator: CoordinatorType {
    weak var delegate: AuthenticationCoordinatorDelegate?

    fileprivate let navigationController: UINavigationController
    fileprivate let managedObjectContext: NSManagedObjectContext
    
    fileprivate var childCoordinators: [CoordinatorType]

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
    func createAppearance() -> DGTAppearance {
        return DGTAppearance()
    }

    func createAuthenticationConfiguration(with appearance: DGTAppearance) -> DGTAuthenticationConfiguration {
        let authenticationConfiguration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        authenticationConfiguration?.appearance = appearance

        return authenticationConfiguration!
    }

    func startDigitsAuthentication(with authenticationConfiguration: DGTAuthenticationConfiguration) {
        // Calling authenticateWithViewController too quickly after application:didFinishLaunchingWithOptions: causes
        // Digits to behave in unexpected ways. Wrapping the call in dispatch_after appears to be an effective workaround.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: { [unowned self] in
            let digits = Digits.sharedInstance()
//            digits.authenticate(with: nil, configuration: authenticationConfiguration, completion: self.digitsAuthenticationCompleted)
            
            digits.authenticate(completion: self.digitsAuthenticationCompleted)
        })
    }

    func digitsAuthenticationCompleted(session: DGTSession?, error: Error?) {
        guard let session = session else {
            delegate?.authenticationCoordinator(self, didEncounter: error!)
            
            return
        }
        
        managedObjectContext.fetchUser(with: session.phoneNumber, completionHandler: { [unowned self] either in
            switch either {
            case .left(let user):
                let user = user ?? User(insertedInto: self.managedObjectContext)
                user.phoneNumber = session.phoneNumber
                
                UserDefaults.standard.set(true, forKey: Constants.UserDefaults.HasLoggedInKey)
                
                self.delegate?.authenticationCoordinator(self, didFinishWith: user)
            case .right(let error):
                self.delegate?.authenticationCoordinator(self, didEncounter: error)
            }
        })
    }
}
