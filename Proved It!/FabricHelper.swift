//
//  FabricHelper.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Crashlytics
import DigitsKit
import Fabric

final class FabricHelper {
    static func initializeFabric() {
        initializeDigits()
        setIncludedKits()
    }

    fileprivate static func initializeDigits() {
        
    }

    fileprivate static func setIncludedKits() {
        Fabric.with([Crashlytics.self, Digits.self])
    }
}
