//
//  UIColor+HexString.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/14/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

extension UIColor {
    static func colorWithHexString(_ hexString: String) -> UIColor {
        var result: UInt32 = 0

        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&result)

        let red = CGFloat((result >> 16) & 0xFF) / 255.0
        let green = CGFloat((result >> 8) & 0xFF) / 255.0
        let blue = CGFloat(result & 0xFF) / 255.0

        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
}
