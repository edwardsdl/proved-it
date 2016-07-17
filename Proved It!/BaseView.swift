//
//  BaseView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

class BaseView: UIView {
    private var didSetupConstraints: Bool = false

    private lazy var radialGradientView: RadialGradientView = {
        let radialGradientView = RadialGradientView()
        radialGradientView.translatesAutoresizingMaskIntoConstraints = false

        return radialGradientView
    }()

    convenience init() {
        self.init(frame: CGRectZero)

        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        addSubview(radialGradientView)
        sendSubviewToBack(radialGradientView)
    }

    override func updateConstraints() {
        if !didSetupConstraints {
            setupConstraints()
        }

        super.updateConstraints()
    }

    func setupConstraints() {
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0))
    }
}
