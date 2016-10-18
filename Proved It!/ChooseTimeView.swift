//
//  ChooseTimeView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ChooseTimeViewDelegate: class {
    func chooseTimeView(_ chooseTimeView: ChooseTimeView, didChooseTimeIntervalSinceStartOfDay timeInterval: TimeInterval)
}

final class ChooseTimeView: BaseView {
    @IBOutlet weak var chooseTimeButton: UIButton!

    weak var delegate: ChooseTimeViewDelegate?

    private var date: Date = Date()

    @IBAction func chooseTimeButtonTouchUpInside(_ sender: UIButton) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let timeInterval = date.timeIntervalSince(startOfDay)

        delegate?.chooseTimeView(self, didChooseTimeIntervalSinceStartOfDay: timeInterval)
    }
    
    func configure(with user: User) {
        
    }
}
