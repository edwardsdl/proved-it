//
//  DashboardCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol DashboardCoordinatorDelegate: class {
    func dashboardCoordinatorDidTapSignOut(dashboardCoordinator: DashboardCoordinator)
}

final class DashboardCoordinator: NSObject, CoordinatorType {
    weak var delegate: DashboardCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let user: User
    private let pageViewController: UIPageViewController
    private let viewControllers: [UIViewController]
    
    private var childCoordinators: [CoordinatorType]
    
    init(with navigationController: UINavigationController, user: User) {
        let countdownViewController = CountdownViewController(with: user)
        let historyViewController = HistoryViewController(with: user)
        let settingsViewController = SettingsViewController(with: user)
        
        self.navigationController = navigationController
        self.user = user
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        self.viewControllers = [countdownViewController, historyViewController, settingsViewController]
        self.childCoordinators = []
        
        super.init()
        
        countdownViewController.delegate = self
        historyViewController.delegate = self
        settingsViewController.delegate = self
    }
    
    func start() {
        guard let firstViewController = viewControllers.first else {
            startErrorCoordinator(with: ApplicationError.FailedToUnwrapValue)
            
            return
        }
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.navigationItem.hidesBackButton = true
        self.pageViewController.title = firstViewController.title
        self.pageViewController.setViewControllers([firstViewController], direction: .Forward, animated: true, completion: nil)
        
        self.navigationController.navigationBarHidden = false
        self.navigationController.pushViewController(self.pageViewController, animated: true)
    }
    
    private func startErrorCoordinator(with error: ErrorType) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
}

extension DashboardCoordinator: CountdownViewControllerDelegate {
    func countdownViewController(countdownViewController: CountdownViewController, didReceive result: Result) {
        
    }
    
    func countdownViewController(countdownViewController: CountdownViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: HistoryViewControllerDelegate {
    
}

extension DashboardCoordinator: SettingsViewControllerDelegate {    
    func settingsViewControllerDidSelectTime(settingsViewController: SettingsViewController) {
        let chooseTimeViewController = ChooseTimeViewController(with: user)
        chooseTimeViewController.delegate = self
        
        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
    
    func settingsViewControllerDidSelectSignificantOther(settingsViewController: SettingsViewController) {
        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController(with: user)
        chooseSignificantOtherViewController.delegate = self
        
        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
    
    func settingsViewControllerDidTapSignOut(settingsViewController: SettingsViewController) {
        delegate?.dashboardCoordinatorDidTapSignOut(self)
    }
    
    func settingsViewController(settingsViewController: SettingsViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove({ $0 === errorCoordinator })
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

extension DashboardCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWith user: User) {
        navigationController.popViewControllerAnimated(true)
    }
    
    func chooseTimeNameViewController(chooseTimeViewController: ChooseTimeViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User) {
        navigationController.popViewControllerAnimated(true)
    }
    
    func chooseSignificantOtherViewController(chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: ErrorType) {
        startErrorCoordinator(with: error)
    }
}
