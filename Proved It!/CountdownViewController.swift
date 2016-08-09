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
    func countdownViewController(countdownViewController: CountdownViewController, didReceive result: Result)
    func countdownViewController(countdownViewController: CountdownViewController, didEncounter error: ErrorType)
}

final class CountdownViewController: BaseViewController<CountdownView> {
    weak var delegate: CountdownViewControllerDelegate?
    
    private let user: User
    
    init(with user: User) {
        self.user = user
        
        super.init()
        
        title = "Time Remaining"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        customView.configure(with: user)
    }
}

extension CountdownViewController: CountdownViewDelegate {
    func countdownView(countdownView: CountdownView, didProveItOn date: NSDate) {

    }
}
