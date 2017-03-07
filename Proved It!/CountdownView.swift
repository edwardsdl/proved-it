//
//  CountdownView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate: class {
    func countdownView(_ countdownView: CountdownView, didEncounter error: Error)
}

final class CountdownView: BaseView {
    @IBOutlet weak var countdownButton: CountdownButton!

    weak var delegate: CountdownViewDelegate?
    
    func configure(with user: User) {
        countdownButton.configure(with: user)
    }
}
