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
    private var coreDataStore: CoreDataStoreType?
    private var resultService: ResultService?
    private var relationshipService: RelationshipService?
    private var userService: UserService?
    private var childCoordinators: [CoordinatorType] = []

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController

        if let coreDataStore = initializeCoreDataStore() {
            self.coreDataStore = coreDataStore
            self.resultService = initializeResultService(withCoreDataStore: coreDataStore)
            self.relationshipService = initializeRelationshipService(withCoreDataStore: coreDataStore)
            self.userService = initializeUserService(withCoreDataStore: coreDataStore)
        }
    }

    private func initializeCoreDataStore() -> CoreDataStoreType? {
        return CoreDataStoreFactory.createCoreDataStore(withCoreDataStoreConfiguration: .Default)
    }

    private func initializeResultService(withCoreDataStore coreDataStore: CoreDataStoreType) -> ResultService {
        let resultApiClient = ResultApiClient()
        let resultService = ResultService(withResultApiClient: resultApiClient, coreDataStore: coreDataStore)

        return resultService
    }

    private func initializeRelationshipService(withCoreDataStore coreDataStore: CoreDataStoreType) -> RelationshipService {
        let relationshipApiClient = RelationshipApiClient()
        let relationshipService = RelationshipService(withRelationshipApiClient: relationshipApiClient, coreDataStore: coreDataStore)

        return relationshipService
    }

    private func initializeUserService(withCoreDataStore coreDataStore: CoreDataStoreType) -> UserService {
        let userApiClient = UserApiClient()
        let userService = UserService(withUserApiClient: userApiClient, coreDataStore: coreDataStore)
        
        return userService
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
