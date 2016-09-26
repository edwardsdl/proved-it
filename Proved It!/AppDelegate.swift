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

    fileprivate var coreDataConfiguration: CoreDataConfiguration!
    fileprivate var managedObjectModel: NSManagedObjectModel!
    fileprivate var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    fileprivate var persistentStore: NSPersistentStore!
    fileprivate var managedObjectContext: NSManagedObjectContext!
    fileprivate var navigationController: UINavigationController!
    fileprivate var appCoordinator: AppCoordinator!
    
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

    fileprivate func createManagedObjectModel(with coreDataConfiguration: CoreDataConfiguration) throws -> NSManagedObjectModel {
        guard let managedObjectModelUrl = coreDataConfiguration.managedObjectModelUrl else {
            throw CoreDataError.failedToCreateManagedObjectModel
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelUrl as URL) else {
            throw CoreDataError.failedToCreateManagedObjectModel
        }
        
        return managedObjectModel
    }
    
    fileprivate func createPersistentStoreCoordinator(with coreDataConfiguration: CoreDataConfiguration, managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        return persistentStoreCoordinator
    }
    
    fileprivate func createPersistentStore(with coreDataConfiguration: CoreDataConfiguration, persistentStoreCoordinator: NSPersistentStoreCoordinator) throws -> NSPersistentStore {
        guard let persistentStoreUrl = coreDataConfiguration.persistentStoreUrl else {
            throw CoreDataError.failedToCreatePersistentStore
        }
        
        guard let persistentStore = try? persistentStoreCoordinator.addPersistentStore(ofType: coreDataConfiguration.storeType, configurationName: nil, at: persistentStoreUrl as URL, options: coreDataConfiguration.persistentStoreOptions) else {
            throw CoreDataError.failedToCreatePersistentStore
        }
        
        return persistentStore
    }
    
    fileprivate func createManagedObjectContext(with persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }

    fileprivate func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightLight)]
        
        return navigationController
    }
    
    fileprivate func createAppCoordinator(with navigationController: UINavigationController) -> AppCoordinator {
        let appCoordinator = AppCoordinator(with: navigationController)

        return appCoordinator
    }

    fileprivate func createWindow(with navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return window
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
