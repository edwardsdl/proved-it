//
//  AppCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol CoordinatorType {
    init(withNavigationController navigationController: UINavigationController)
    func start()
}

final class AppCoordinator: CoordinatorType {
    private var childCoordinators: [CoordinatorType] = []
    private let navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

    }
}