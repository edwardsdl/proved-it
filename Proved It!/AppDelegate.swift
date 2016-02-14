//
//  AppDelegate.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/11/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import AWSCognito
import CoreData
import Crashlytics
import DigitsKit
import Fabric
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private var appCoordinator: AppCoordinator?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        do {
            let navigationController = UINavigationController()

            appCoordinator = initializeAppCoordinator(withNavigationController: navigationController)
            window = initializeWindow(withNavigationController: navigationController)

            try CoreDataHelper.initializeManagedObjectContext()

            initializeFabric()
        } catch {

        }

        return true
    }

    private func initializeAppCoordinator(withNavigationController navigationController: UINavigationController) -> AppCoordinator {
        let appCoordinator = AppCoordinator(withNavigationController: navigationController)
        appCoordinator.start()

        return appCoordinator
    }

    private func initializeWindow(withNavigationController navigationController: UINavigationController) -> UIWindow {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        return window
    }

    private func initializeFabric() {
        Fabric.with([AWSCognito.self, Crashlytics.self, Digits.self])
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

