//
//  DashboardCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

final class DashboardCoordinator: NSObject, CoordinatorType {
    private let navigationController: UINavigationController
    private let user: User
    private let pageViewController: UIPageViewController
    private let viewControllers: [UIViewController]
    
    private var childCoordinators: [CoordinatorType]
    
    init(with navigationController: UINavigationController, user: User) {
        self.navigationController = navigationController
        self.user = user
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.viewControllers = [CountdownViewController(with: user), CountdownViewController(with: user)]
        self.childCoordinators = []
        
        super.init()
    }
    
    func start() {
        guard let firstViewController = viewControllers.first else {
            return
        }
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.title = firstViewController.title
        self.pageViewController.setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        
        self.navigationController.pushViewController(self.pageViewController, animated: true)
    }
}

extension DashboardCoordinator: UIPageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        pageViewController.title = currentViewController.title
    }
}

extension DashboardCoordinator: UIPageViewControllerDataSource {
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return nil
        }
        
        guard let currentIndex = viewControllers.indexOf(currentViewController) else {
            return nil
        }
        
        let previousViewControllerIndex = currentIndex - 1
        
        guard 0..<viewControllers.count ~= previousViewControllerIndex else {
            return nil
        }
        
        return viewControllers[previousViewControllerIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return nil
        }
        
        guard let currentIndex = viewControllers.indexOf(currentViewController) else {
            return nil
        }
        
        let nextViewControllerIndex = currentIndex + 1
        
        guard 0..<viewControllers.count ~= nextViewControllerIndex else {
            return nil
        }
        
        return viewControllers[nextViewControllerIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return 0
        }
        
        guard let currentIndex = viewControllers.indexOf(currentViewController) else {
            return 0
        }
        
        return currentIndex
    }
}
