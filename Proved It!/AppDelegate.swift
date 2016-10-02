//
//  AppDelegate.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/11/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private var coreDataConfiguration: CoreDataConfiguration!
    private var managedObjectModel: NSManagedObjectModel!
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    private var persistentStore: NSPersistentStore!
    private var managedObjectContext: NSManagedObjectContext!
    private var navigationController: UINavigationController!
    private var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        navigationController = createNavigationController()
        appCoordinator = createAppCoordinator(with: navigationController)
        window = createWindow(with: navigationController)

        do {
            coreDataConfiguration = CoreDataConfiguration.default
            managedObjectModel = try createManagedObjectModel(with: coreDataConfiguration)
            persistentStoreCoordinator = createPersistentStoreCoordinator(with: coreDataConfiguration, managedObjectModel: managedObjectModel)
            persistentStore = try createPersistentStore(with: coreDataConfiguration, persistentStoreCoordinator: persistentStoreCoordinator)
            managedObjectContext = createManagedObjectContext(with: persistentStoreCoordinator)
        } catch {
            appCoordinator.start(with: error)
        }
        
        appCoordinator.start(with: managedObjectContext)
        
        FabricHelper.initializeFabric()
        
        return true
    }
    
    private func createManagedObjectModel(with coreDataConfiguration: CoreDataConfiguration) throws -> NSManagedObjectModel {
        guard let managedObjectModelUrl = coreDataConfiguration.managedObjectModelUrl else {
            throw CoreDataError.failedToCreateManagedObjectModel
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelUrl as URL) else {
            throw CoreDataError.failedToCreateManagedObjectModel
        }
        
        return managedObjectModel
    }
    
    private func createPersistentStoreCoordinator(with coreDataConfiguration: CoreDataConfiguration, managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        return persistentStoreCoordinator
    }
    
    private func createPersistentStore(with coreDataConfiguration: CoreDataConfiguration, persistentStoreCoordinator: NSPersistentStoreCoordinator) throws -> NSPersistentStore {
        guard let persistentStoreUrl = coreDataConfiguration.persistentStoreUrl else {
            throw CoreDataError.failedToCreatePersistentStore
        }
        
        guard let persistentStore = try? persistentStoreCoordinator.addPersistentStore(ofType: coreDataConfiguration.storeType, configurationName: nil, at: persistentStoreUrl as URL, options: coreDataConfiguration.persistentStoreOptions) else {
            throw CoreDataError.failedToCreatePersistentStore
        }
        
        return persistentStore
    }
    
    private func createManagedObjectContext(with persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }
    
    private func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)]
        
        return navigationController
    }
    
    private func createAppCoordinator(with navigationController: UINavigationController) -> AppCoordinator {
        let appCoordinator = AppCoordinator(with: navigationController)

        return appCoordinator
    }
    
    private func createWindow(with navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return window
    }
}
