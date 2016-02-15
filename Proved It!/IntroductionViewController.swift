//
//  IntroductionViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol IntroductionViewControllerDelegate: class {
    func introductionViewControllerDidTapProveItButton(introductionViewController: IntroductionViewController)
}

final class IntroductionViewController: BaseViewController<IntroductionView> {
    weak var delegate: IntroductionViewControllerDelegate?

    override init() {
        super.init()
    }

    override func viewDidLoad() {
        customView.proveItButton.addTarget(self, action: "proveItButtonTapped:", forControlEvents: .TouchUpInside)
    }

    dynamic private func proveItButtonTapped(sender: UIButton) {
        delegate?.introductionViewControllerDidTapProveItButton(self)
    }
}
