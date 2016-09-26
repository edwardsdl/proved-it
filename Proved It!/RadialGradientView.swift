//
//  RadialGradientView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class RadialGradientView: UIView {
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let gradientColors = [UIColor.provedItDarkGrayColor().cgColor, UIColor.black.cgColor]
        let gradientLocations = [CGFloat(0), CGFloat(1)]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: gradientColors as CFArray, locations: gradientLocations)

        let startPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let endPoint = CGPoint(x: rect.width / 2, y: rect.height / 2)
        context?.drawRadialGradient(gradient!, startCenter: startPoint, startRadius: 0, endCenter: endPoint, endRadius: rect.height, options: .drawsAfterEndLocation)
    }
}
