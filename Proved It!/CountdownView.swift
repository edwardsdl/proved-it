//
//  CountdownView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate: class {
    func countdownView(countdownView: CountdownView, didProveItOn date: NSDate)
}

final class CountdownView: BaseView {
    @IBOutlet weak var proveItButton: UIButton!
    
    weak var delegate: CountdownViewDelegate?
    
    private var user: User?
    private var timer: NSTimer?
    
    @IBAction func proveItButtonTouchUpInside(sender: UIButton) {
        delegate?.countdownView(self, didProveItOn: NSDate())
    }
    
    override func awakeFromNib() {
        configureProveItButton()
    }
    
    func configure(with user: User) {
        guard timer == nil else {
            return
        }
        
        self.user = user
        self.timer = createTimer()
    }
    
    private func createTimer() -> NSTimer {
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.5,
                                                           target: self,
                                                           selector: #selector(CountdownView.updateCountdown),
                                                           userInfo: nil,
                                                           repeats: true)
        timer.fire()
        
        return timer
    }
    
    @objc private func updateCountdown() {
        guard let timeInterval = user?.configuration?.time else {
            return
        }
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let targetDate = calendar.startOfDayForDate(date).dateByAddingTimeInterval(timeInterval)
        let components = calendar.components([.Hour, .Minute, .Second], fromDate: date, toDate: targetDate, options: .MatchStrictly)
        let sign = date.compare(targetDate) == .OrderedDescending ? "-" : ""
        let hours = String(format: "%02d", abs(components.hour))
        let minutes = String(format: "%02d", abs(components.minute))
        let seconds = String(format: "%02d", abs(components.second))
        let timeRemaining = "\(sign)\(hours):\(minutes):\(seconds)"
        
        proveItButton.setTitle(timeRemaining, forState: .Normal)
    }
}

private extension CountdownView {
    private func configureProveItButton() {
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().CGColor
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
    }
    
    private func timeStringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(date)
    }
}
