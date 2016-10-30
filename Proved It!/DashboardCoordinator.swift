//
//  DashboardCoordinator.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import MessageUI
import UIKit

protocol DashboardCoordinatorDelegate: class {
    func dashboardCoordinatorDidTapSignOut(_ dashboardCoordinator: DashboardCoordinator)
}

final class DashboardCoordinator: NSObject, CoordinatorType {
    weak var delegate: DashboardCoordinatorDelegate?
    
    fileprivate let navigationController: UINavigationController
    fileprivate let user: User
    fileprivate let pageViewController: UIPageViewController
    fileprivate let viewControllers: [UIViewController]
    
    fileprivate var childCoordinators: [CoordinatorType]
    
    init(with navigationController: UINavigationController, user: User) {
        let countdownViewController = CountdownViewController()
        countdownViewController.configure(with: user)
        
        let historyViewController = HistoryViewController()
        historyViewController.configure(with: user)
        
        let settingsViewController = SettingsViewController()
        settingsViewController.configure(with: user)
        
        self.navigationController = navigationController
        self.user = user
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.viewControllers = [countdownViewController, historyViewController, settingsViewController]
        self.childCoordinators = []
        
        super.init()
        
        countdownViewController.delegate = self
        historyViewController.delegate = self
        settingsViewController.delegate = self
    }
    
    func start() {
        guard let firstViewController = viewControllers.first else {
            startErrorCoordinator(with: ApplicationError.failedToUnwrapValue)
            
            return
        }
        
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.navigationItem.hidesBackButton = true
        self.pageViewController.title = firstViewController.title
        self.pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        
        self.navigationController.isNavigationBarHidden = false
        self.navigationController.pushViewController(self.pageViewController, animated: true)
    }
    
    fileprivate func startErrorCoordinator(with error: Error) {
        let errorCoordinator = ErrorCoordinator(with: navigationController)
        errorCoordinator.delegate = self
        errorCoordinator.start(with: error)
        
        childCoordinators.append(errorCoordinator)
    }
}

extension DashboardCoordinator: CountdownViewControllerDelegate {
    func countdownViewControllerDidTapCountdownButton(_ countdownViewController: CountdownViewController) {
        guard MFMessageComposeViewController.canSendText() else {
            startErrorCoordinator(with: ApplicationError.other(message: "Failed to display composition interface"))
            
            return
        }
        
        let messageComposeViewController = MFMessageComposeViewController()
        messageComposeViewController.body = "I already proved it!"
        messageComposeViewController.messageComposeDelegate = self
        messageComposeViewController.recipients = [user.significantOther?.phoneNumber ?? ""]

        navigationController.present(messageComposeViewController, animated: true, completion: nil)
    }
    
    func countdownViewController(_ countdownViewController: CountdownViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}

extension DashboardCoordinator: HistoryViewControllerDelegate {
    
}

extension DashboardCoordinator: SettingsViewControllerDelegate {    
    func settingsViewControllerDidSelectTime(_ settingsViewController: SettingsViewController) {
        let chooseTimeViewController = ChooseTimeViewController()
        chooseTimeViewController.delegate = self
        chooseTimeViewController.configure(with: user, isOnboarding: false)
        
        navigationController.pushViewController(chooseTimeViewController, animated: true)
    }
    
    func settingsViewControllerDidSelectSignificantOther(_ settingsViewController: SettingsViewController) {
        let chooseSignificantOtherViewController = ChooseSignificantOtherViewController()
        chooseSignificantOtherViewController.delegate = self
        chooseSignificantOtherViewController.configure(with: user)
        
        navigationController.pushViewController(chooseSignificantOtherViewController, animated: true)
    }
    
    func settingsViewControllerDidTapSignOut(_ settingsViewController: SettingsViewController) {
        delegate?.dashboardCoordinatorDidTapSignOut(self)
    }
    
    func settingsViewController(_ settingsViewController: SettingsViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: ErrorCoordinatorDelegate {
    func errorCoordinatorDidFinish(_ errorCoordinator: ErrorCoordinator) {
        childCoordinators.remove(predicate: { $0 === errorCoordinator })
    }
}

extension DashboardCoordinator: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return
        }
        
        pageViewController.title = currentViewController.title
    }
}

extension DashboardCoordinator: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return nil
        }
        
        guard let currentIndex = viewControllers.index(of: currentViewController) else {
            return nil
        }
        
        let previousViewControllerIndex = currentIndex - 1
        
        guard 0..<viewControllers.count ~= previousViewControllerIndex else {
            return nil
        }
        
        return viewControllers[previousViewControllerIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return nil
        }
        
        guard let currentIndex = viewControllers.index(of: currentViewController) else {
            return nil
        }
        
        let nextViewControllerIndex = currentIndex + 1
        
        guard 0..<viewControllers.count ~= nextViewControllerIndex else {
            return nil
        }
        
        return viewControllers[nextViewControllerIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return viewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentViewController = pageViewController.viewControllers?.first else {
            return 0
        }
        
        guard let currentIndex = viewControllers.index(of: currentViewController) else {
            return 0
        }
        
        return currentIndex
    }
}

extension DashboardCoordinator: ChooseTimeViewControllerDelegate {
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didFinishWith user: User) {
        navigationController.popViewController(animated: true)
    }
    
    func chooseTimeViewController(_ chooseTimeViewController: ChooseTimeViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}

extension DashboardCoordinator: ChooseSignificantOtherViewControllerDelegate {
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didFinishWith user: User) {
        navigationController.popViewController(animated: true)
    }
    
    func chooseSignificantOtherViewController(_ chooseSignificantOtherViewController: ChooseSignificantOtherViewController, didEncounter error: Error) {
        startErrorCoordinator(with: error)
    }
}
