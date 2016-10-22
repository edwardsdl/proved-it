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
    @IBOutlet weak var proveItButton: UIButton!
    
    weak var delegate: CountdownViewDelegate?
    
    private var user: User?
    private var timer: Timer?
    
    func configure(with user: User) {
        guard timer == nil else {
            return
        }

        configureProveItButton()
        configureTimer()
        
        self.user = user
    }
    
    @objc private func updateCountdown() {
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
    
    private func configureTimer() {
        let timer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(updateCountdown),
                                         userInfo: nil,
                                         repeats: true)
        timer.fire()
        
        self.timer = timer
    }
    
    private func configureProveItButton() {
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().cgColor
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
    }
    
    private func timeString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: date)
    }
}
