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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        navigationController = UINavigationController()
        appCoordinator = createAppCoordinator(with: navigationController)
        window = createWindow(with: navigationController)

        do {
            coreDataConfiguration = CoreDataConfiguration.Default
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
            throw CoreDataError.UnableToInitializeManagedObjectModel
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOfURL: managedObjectModelUrl) else {
            throw CoreDataError.UnableToInitializeManagedObjectModel
        }
        
        return managedObjectModel
    }
    
    private func createPersistentStoreCoordinator(with coreDataConfiguration: CoreDataConfiguration, managedObjectModel: NSManagedObjectModel) -> NSPersistentStoreCoordinator {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        return persistentStoreCoordinator
    }
    
    private func createPersistentStore(with coreDataConfiguration: CoreDataConfiguration, persistentStoreCoordinator: NSPersistentStoreCoordinator) throws -> NSPersistentStore {
        guard let persistentStoreUrl = coreDataConfiguration.persistentStoreUrl else {
            throw CoreDataError.UnableToInitializePersistentStore
        }
        
        guard let persistentStore = try? persistentStoreCoordinator.addPersistentStoreWithType(coreDataConfiguration.storeType, configuration: nil, URL: persistentStoreUrl, options: coreDataConfiguration.persistentStoreOptions) else {
            throw CoreDataError.UnableToInitializePersistentStore
        }
        
        return persistentStore
    }
    
    private func createManagedObjectContext(with persistentStoreCoordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        return managedObjectContext
    }

    private func createAppCoordinator(with navigationController: UINavigationController) -> AppCoordinator {
        let appCoordinator = AppCoordinator(withNavigationController: navigationController)

        return appCoordinator
    }

    private func createWindow(with navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return window
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
