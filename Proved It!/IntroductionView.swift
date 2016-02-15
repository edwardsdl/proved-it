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
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().CGColor
    }

//    override func setupConstraints() {
//        super.setupConstraints()
//
//        addConstraint(NSLayoutConstraint(item: proveItButton, attribute: ., relatedBy: <#T##NSLayoutRelation#>, toItem: <#T##AnyObject?#>, attribute: <#T##NSLayoutAttribute#>, multiplier: <#T##CGFloat#>, constant: <#T##CGFloat#>)
//    }
}
