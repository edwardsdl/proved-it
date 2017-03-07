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
    func chooseTimeView(_ chooseTimeView: ChooseTimeView, didEncounter error: Error)
}

final class ChooseTimeView: BaseView {
    @IBOutlet weak var chooseTimeDatePicker: ChooseTimeDatePicker!

    weak var delegate: ChooseTimeViewDelegate?

    @IBAction func chooseTimeDatePickerDidChangeValue() {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        
        let roundedDate = Calendar.current.nextDate(after: chooseTimeDatePicker.date,
                                                    matching: DateComponents(second: 0, nanosecond: 0),
                                                    matchingPolicy: .strict,
                                                    repeatedTimePolicy: .first,
                                                    direction: .backward)
        
        if let timeInterval = roundedDate?.timeIntervalSince(startOfDay) {
            delegate?.chooseTimeView(self, didChooseTimeIntervalSinceStartOfDay: timeInterval)
        } else {
            delegate?.chooseTimeView(self, didEncounter: ApplicationError.failedToUnwrapValue)
        }
    }
    
    func configure(with user: User) {
        chooseTimeDatePicker.configure()
    }
}
