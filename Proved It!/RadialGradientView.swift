//
//  RadialGradientView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class RadialGradientView: UIView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientColors = [UIColor.provedItDarkGrayColor().CGColor, UIColor.blackColor().CGColor]
        let gradientLocations = [CGFloat(0), CGFloat(1)]
        let gradient = CGGradientCreateWithColors(colorSpace, gradientColors, gradientLocations)

        let startPoint = CGPointMake(rect.width / 2, rect.height / 2)
        let endPoint = CGPointMake(rect.width / 2, rect.height / 2)
        CGContextDrawRadialGradient(context, gradient, startPoint, 0, endPoint, rect.height, .DrawsAfterEndLocation)
    }
}