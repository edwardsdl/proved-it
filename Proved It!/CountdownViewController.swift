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
    func countdownViewControllerDidTapCountdownButton(_ countdownViewController: CountdownViewController)
    func countdownViewController(_ countdownViewController: CountdownViewController, didEncounter error: Error)
}

final class CountdownViewController: BaseViewController<CountdownView> {    
    weak var delegate: CountdownViewControllerDelegate?
    
    private var user: User?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.shared.isIdleTimerDisabled = false
    }

    @IBAction func countdownButtonTapped() {
        guard let configuration = user?.configuration , !configuration.isTargetDateInFuture else {
            return
        }
        
        delegate?.countdownViewControllerDidTapCountdownButton(self)
    }
    
    func configure(with user: User) {
        customView.delegate = self
        customView.configure(with: user)
        
        self.user = user
    }
}

extension CountdownViewController: CountdownViewDelegate {
    func countdownView(_ countdownView: CountdownView, didEncounter error: Error) {
        delegate?.countdownViewController(self, didEncounter: error)
    }
}
