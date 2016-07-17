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
    
    private let user: User
    
    init(with user: User) {
        self.user = user
        
        super.init()
        
        title = "History"
    }
}
