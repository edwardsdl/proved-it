//
//  Proved_It_Tests.swift
//  Proved It!Tests
//
//  Created by Dallas Edwards on 2/11/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import XCTest
@testable import ProvedIt

final class CoreDataStoreTests: XCTestCase {
    func testCanInsertObject() {
        let userModel = UserModel()
        userModel.name = "Name"
        userModel.phoneNumber = "8885551212"

        let coreDataStore = CoreDataStoreFactory.createCoreDataStore(withCoreDataStoreConfiguration: .UnitTest)!
        let userEntity = insertUserModel(userModel, withCoreDataStore: coreDataStore)
        let fetchedUserEntity = fetchUserEntity(userEntity, withCoreDataStore: coreDataStore)

        XCTAssertEqual(userEntity.objectID, fetchedUserEntity?.objectID)
    }

    private func insertUserModel(userModel: UserModel, withCoreDataStore coreDataStore: CoreDataStoreType) -> UserEntity {
        let userEntity = userModel.toManagedObject(insertIntoManagedObjectContext: coreDataStore.managedObjectContext)

        coreDataStore.managedObjectContext.insertObject(userEntity)
        coreDataStore.save()

        return userEntity
    }

    private func fetchUserEntity(userEntity: UserEntity, withCoreDataStore coreDataStore: CoreDataStoreType) -> UserEntity? {
        let predicate = NSPredicate(format: "SELF == %@", userEntity)

        let fetchRequest = NSFetchRequest(entityName: String(UserEntity))
        fetchRequest.predicate = predicate

        let fetchedUserEntities = try? coreDataStore.managedObjectContext.executeFetchRequest(fetchRequest)
        let fetchUserEntity = fetchedUserEntities?.first as? UserEntity

        return fetchUserEntity
    }
}
