//
//  ErrorCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 6/28/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ErrorCoordinatorDelegate: class {
    func errorCoordinatorDidFinish(_ errorCoordinator: ErrorCoordinator)
}

final class ErrorCoordinator: CoordinatorType {
    weak var delegate: ErrorCoordinatorDelegate?
    
    fileprivate let navigationController: UINavigationController
    
    fileprivate var childCoordinators: [CoordinatorType] = []
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(with error: Error) {
        switch error {
        case let error as ApplicationError:
            handle(error)
        case let error as CoreDataError:
            handle(error)
        case let error as ValidationError:
            handle(error)
        default:
            handle(error)
        }
    }
    
    fileprivate func handle(_ error: ApplicationError) {
        displayAlert(with: error.message)
    }
    
    fileprivate func handle(_ error: CoreDataError) {
        displayAlert(with: error.message)
    }
    
    fileprivate func handle(_ error: ValidationError) {
        displayAlert(with: error.message)
    }
    
    fileprivate func handle(_ error: Error) {
        displayAlert(with: "An unknown error occurred")
    }
    
    fileprivate func displayAlert(with message: String) {
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in self.delegate?.errorCoordinatorDidFinish(self) })
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(alertAction)
        
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
