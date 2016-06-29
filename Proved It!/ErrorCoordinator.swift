//
//  ErrorCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ErrorCoordinatorDelegate: class {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator)
}

final class ErrorCoordinator: CoordinatorType {
    weak var delegate: ErrorCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private var childCoordinators: [CoordinatorType] = []
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with error: ErrorType) {
        switch error {
        case let error as CoreDataError:
            handle(error)
        case let error as ValidationError:
            handle(error)
        default:
            handle(error)
        }
    }
}

private extension ErrorCoordinator {
    private func handle(error: CoreDataError) {
        displayAlert(with: error.message)
    }
    
    private func handle(error: ValidationError) {
        displayAlert(with: error.message)
    }
    
    private func handle(error: ErrorType) {
        displayAlert(with: "An unknown error occurred")
    }
    
    private func displayAlert(with message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .Default, handler: { _ in self.delegate?.errorCoordinatorDidFinish(self) })
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        alertController.addAction(alertAction)
        
        navigationController.presentViewController(alertController, animated: true, completion: nil)
    }
}
