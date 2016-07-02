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
    
    override func awakeFromNib() {
        configureProveItButton()
    }
    
    @IBAction func proveItButtonTouchUpInside(sender: UIButton) {
        delegate?.countdownView(self, didProveItOn: NSDate())
    }
}

private extension CountdownView {
    private func configureProveItButton() {
        let timeString = timeStringFromDate(NSDate())
        
        proveItButton.layer.borderColor = UIColor.provedItGreenColor().CGColor
        proveItButton.layer.borderWidth = 2
        proveItButton.layer.cornerRadius = proveItButton.bounds.width / 2
        proveItButton.setTitle(timeString, forState: .Normal)
    }
    
    private func timeStringFromDate(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(date)
    }
}
