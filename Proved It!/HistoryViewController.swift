//
//  HistoryViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/7/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol HistoryViewControllerDelegate: class {
    
}

final class HistoryViewController: BaseViewController<HistoryView> {
    weak var delegate: HistoryViewControllerDelegate?
    
    fileprivate var user: User?
    
    func configure(with user: User) {
        self.user = user
    }
}
