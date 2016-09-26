//
//  BaseView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

class BaseView: UIView {
    fileprivate var didSetupConstraints: Bool = false

    fileprivate lazy var radialGradientView: RadialGradientView = {
        let radialGradientView = RadialGradientView()
        radialGradientView.translatesAutoresizingMaskIntoConstraints = false

        return radialGradientView
    }()

    convenience init() {
        self.init(frame: CGRect.zero)

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

    fileprivate func commonInit() {
        addSubview(radialGradientView)
        sendSubview(toBack: radialGradientView)
    }

    override func updateConstraints() {
        if !didSetupConstraints {
            setupConstraints()
        }

        super.updateConstraints()
    }

    func setupConstraints() {
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: radialGradientView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
    }
}
