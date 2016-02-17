//
//  ChooseTimeViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ChooseTimeViewControllerDelegate: class {
    func chooseTimeViewControllerDidChooseTime(chooseTimeViewController: ChooseTimeViewController)
}

final class ChooseTimeViewController: BaseViewController<ChooseTimeView> {
    weak var delegate: ChooseTimeViewControllerDelegate?

    override func viewDidLoad() {
        configureChooseTimeButton()
    }

    private func configureChooseTimeButton() {
        customView.chooseTimeButton.addTarget(self, action: "chooseTimeButtonTouchUpInside:", forControlEvents: .TouchUpInside)
    }

    func chooseTimeButtonTouchUpInside(sender: UIButton) {
        delegate?.chooseTimeViewControllerDidChooseTime(self)

        print("Done!")
    }
}
