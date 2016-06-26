//
//  ChooseTimeViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ChooseTimeViewControllerDelegate: class {
    func chooseTimeViewController(chooseTimeViewController: ChooseTimeViewController, didFinishWithUser user: User)
}

final class ChooseTimeViewController: BaseViewController<ChooseTimeView> {
    private let coreDataStore: CoreDataStoreType
    private let user: User

    weak var delegate: ChooseTimeViewControllerDelegate?

    init(withCoreDataStore coreDataStore: CoreDataStoreType, user: User) {
        self.coreDataStore = coreDataStore

        self.user = user
        self.user.configuration = Configuration(insertIntoManagedObjectContext: coreDataStore.managedObjectContext)
    }

    override func viewDidLoad() {
        customView.delegate = self
    }
}

extension ChooseTimeViewController: ChooseTimeViewDelegate {
    func chooseTimeView(chooseTimeView: ChooseTimeView, didChooseTimeIntervalSinceStartOfDay timeInterval: NSTimeInterval) {
        user.configuration?.time = timeInterval

        delegate?.chooseTimeViewController(self, didFinishWithUser: user)
    }
}
