//
//  IntroductionView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class IntroductionView: BaseView {
    @IBOutlet weak var proveItButton: UIButton!

    override func awakeFromNib() {
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().CGColor
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
    }
}
