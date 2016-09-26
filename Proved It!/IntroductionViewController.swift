//
//  IntroductionViewController.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol IntroductionViewControllerDelegate: class {
    func introductionViewControllerDidTapProveItButton(_ introductionViewController: IntroductionViewController)
}

final class IntroductionViewController: BaseViewController<IntroductionView> {
    weak var delegate: IntroductionViewControllerDelegate?

    override func viewDidLoad() {
        customView.proveItButton.addTarget(self, action: #selector(IntroductionViewController.proveItButtonTapped(_:)), for: .touchUpInside)
    }

    func proveItButtonTapped(_ sender: UIButton) {
        delegate?.introductionViewControllerDidTapProveItButton(self)
    }
}
