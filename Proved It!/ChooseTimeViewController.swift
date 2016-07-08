//
//  ChooseTimeViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import CoreData
import UIKit

protocol ChooseTimeViewControllerDelegate: class {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWithUser user: User)
    func chooseTimeNameViewController(chooseTimeViewController: ChooseTimeViewController, didEncounter error: ErrorType)
}

final class ChooseTimeViewController: BaseViewController<ChooseTimeView> {
    weak var delegate: ChooseTimeViewControllerDelegate?
    
    private let user: User

    init(with user: User) {
        self.user = user
        self.user.configuration = Configuration(insertIntoManagedObjectContext: user.managedObjectContext!)
    }

    override func viewDidLoad() {
        customView.delegate = self
    }
}

extension ChooseTimeViewController: ChooseTimeViewDelegate {
    func chooseTimeView(chooseTimeView: ChooseTimeView, didChooseTimeIntervalSinceStartOfDay timeInterval: NSTimeInterval) {
        user.configuration?.time = timeInterval

        user.managedObjectContext?.save({ [unowned self] either in
            switch either {
            case .Left:
                self.delegate?.chooseTimeViewController(self, didFinishWithUser: self.user)
            case .Right(let error):
                self.delegate?.chooseTimeNameViewController(self, didEncounter: error)
            }
        })
    }
}
