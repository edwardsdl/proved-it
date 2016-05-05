//
//  ChooseTimeView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/15/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol ChooseTimeViewDelegate: class {
    func chooseTimeView(chooseTimeView: ChooseTimeView, didChooseTimeIntervalSinceStartOfDay timeInterval: NSTimeInterval)
}

final class ChooseTimeView: BaseView {
    @IBOutlet weak var chooseTimeButton: UIButton!

    weak var delegate: ChooseTimeViewDelegate?

    private var date: NSDate = NSDate()

    override func awakeFromNib() {
        configureChooseTimeButton()
        configurePanGestureRecognizer()
    }

    private func configureChooseTimeButton() {
        let timeString = timeStringFromDate(date)

        chooseTimeButton.layer.borderColor = UIColor.provedItOrangeColor().CGColor
        chooseTimeButton.layer.borderWidth = 2
        chooseTimeButton.layer.cornerRadius = chooseTimeButton.bounds.width / 2
        chooseTimeButton.setTitle(timeString, forState: .Normal)
    }

    private func timeStringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle

        return dateFormatter.stringFromDate(date)
    }

    private func configurePanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ChooseTimeView.panGestureRecognizerValueChanged(_:)))

        addGestureRecognizer(panGestureRecognizer)
    }

    func panGestureRecognizerValueChanged(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began, .Changed:
            let changeInSeconds = calculateChangeInSeconds(withPanGestureRecognizer: sender)
            let date = updateDateByAddingSeconds(changeInSeconds)
            let timeString = timeStringFromDate(date)

            chooseTimeButton.setTitle(timeString, forState: .Normal)
        default:
            break
        }
    }

    private func calculateChangeInSeconds(withPanGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> Int {
        let velocity = panGestureRecognizer.velocityInView(self)
        let changeInTime = velocity.x * 0.20
        let roundedChangeInTime = round(changeInTime)

        return Int(roundedChangeInTime)
    }

    private func updateDateByAddingSeconds(seconds: Int) -> NSDate {
        let currentCalendar = NSCalendar.currentCalendar()
        let newDate = currentCalendar.dateByAddingUnit(.Second, value: seconds, toDate: date, options: .MatchNextTime)

        date = newDate ?? NSDate()

        return date
    }

    @IBAction func chooseTimeButtonTouchUpInside(sender: UIButton) {
        let calendar = NSCalendar.currentCalendar()
        let startOfDay = calendar.startOfDayForDate(date)
        let timeInterval = date.timeIntervalSinceDate(startOfDay)

        delegate?.chooseTimeView(self, didChooseTimeIntervalSinceStartOfDay: timeInterval)
    }
}
