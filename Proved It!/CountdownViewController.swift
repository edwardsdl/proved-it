//
//  CountdownViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol CountdownViewControllerDelegate: class {
    func countdownViewController(_ countdownViewController: CountdownViewController, didReceive result: Result)
    func countdownViewController(_ countdownViewController: CountdownViewController, didEncounter error: Error)
}

final class CountdownViewController: BaseViewController<CountdownView> {
    weak var delegate: CountdownViewControllerDelegate?
    
    fileprivate var user: User?
    
    func configure(with user: User) {
        customView.delegate = self
        customView.configure(with: user)
        
        self.user = user
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false
    }
}

extension CountdownViewController: CountdownViewDelegate {
    func countdownView(_ countdownView: CountdownView, didProveItOn date: Date) {

    }
}
