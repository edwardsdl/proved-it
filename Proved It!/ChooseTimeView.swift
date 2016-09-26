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

    fileprivate var date: Date = Date()

    override func awakeFromNib() {
        configureChooseTimeButton()
        configurePanGestureRecognizer()
    }

    fileprivate func configureChooseTimeButton() {
        let timeString = timeStringFromDate(date)

        chooseTimeButton.layer.borderColor = UIColor.provedItOrangeColor().cgColor
        chooseTimeButton.layer.borderWidth = 2
        chooseTimeButton.layer.cornerRadius = chooseTimeButton.bounds.width / 2
        chooseTimeButton.setTitle(timeString, for: UIControlState())
    }

    fileprivate func timeStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short

        return dateFormatter.string(from: date)
    }

    fileprivate func configurePanGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ChooseTimeView.panGestureRecognizerValueChanged(_:)))

        addGestureRecognizer(panGestureRecognizer)
    }

    func panGestureRecognizerValueChanged(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            let changeInSeconds = calculateChangeInSeconds(withPanGestureRecognizer: sender)
            let date = updateDateByAddingSeconds(changeInSeconds)
            let timeString = timeStringFromDate(date)

            chooseTimeButton.setTitle(timeString, for: UIControlState())
        default:
            break
        }
    }

    fileprivate func calculateChangeInSeconds(withPanGestureRecognizer panGestureRecognizer: UIPanGestureRecognizer) -> Int {
        let velocity = panGestureRecognizer.velocity(in: self)
        let changeInTime = velocity.x * 0.20
        let roundedChangeInTime = round(changeInTime)

        return Int(roundedChangeInTime)
    }

    fileprivate func updateDateByAddingSeconds(_ seconds: Int) -> Date {
        let currentCalendar = Calendar.current
        let newDate = (currentCalendar as NSCalendar).date(byAdding: .second, value: seconds, to: date, options: .matchNextTime)

        date = newDate ?? Date()

        return date
    }

    @IBAction func chooseTimeButtonTouchUpInside(_ sender: UIButton) {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let timeInterval = date.timeIntervalSince(startOfDay)

        delegate?.chooseTimeView(self, didChooseTimeIntervalSinceStartOfDay: timeInterval)
    }
}
