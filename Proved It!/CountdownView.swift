//
//  CountdownView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/1/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

protocol CountdownViewDelegate: class {
    func countdownView(_ countdownView: CountdownView, didProveItOn date: Date)
}

final class CountdownView: BaseView {
    @IBOutlet weak var proveItButton: UIButton!
    
    weak var delegate: CountdownViewDelegate?
    
    fileprivate var user: User?
    fileprivate var timer: Timer?
    
    @IBAction func proveItButtonTouchUpInside(_ sender: UIButton) {
        delegate?.countdownView(self, didProveItOn: Date())
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
    
    fileprivate func createTimer() -> Timer {
        let timer = Timer.scheduledTimer(timeInterval: 0.5,
                                                           target: self,
                                                           selector: #selector(CountdownView.updateCountdown),
                                                           userInfo: nil,
                                                           repeats: true)
        timer.fire()
        
        return timer
    }
    
    @objc fileprivate func updateCountdown() {
        guard let timeInterval = user?.configuration?.time else {
            return
        }
        
        let date = Date()
        let calendar = Calendar.current
        let targetDate = calendar.startOfDay(for: date).addingTimeInterval(timeInterval)
        let components = (calendar as NSCalendar).components([.hour, .minute, .second], from: date, to: targetDate, options: .matchStrictly)
        let sign = date.compare(targetDate) == .orderedDescending ? "-" : ""
        let hours = String(format: "%02d", abs(components.hour!))
        let minutes = String(format: "%02d", abs(components.minute!))
        let seconds = String(format: "%02d", abs(components.second!))
        let timeRemaining = "\(sign)\(hours):\(minutes):\(seconds)"
        
        proveItButton.setTitle(timeRemaining, for: UIControlState())
    }
}

private extension CountdownView {
    func configureProveItButton() {
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().cgColor
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
    }
    
    func timeStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}
