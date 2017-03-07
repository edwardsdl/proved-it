//
//  ChooseTimeDatePicker.swift
//  Proved It!
//
//  Created by Dallas Edwards on 10/2/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class ChooseTimeDatePicker: UIDatePicker {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayer()
    }
    
    func configure() {
        configureView()
        configureLayer()
    }
    
    private func configureView() {
        backgroundColor = UIColor.clear
        datePickerMode = .time
        subviews.first?.frame.origin.x = 5
        
        setValue(UIColor.white, forKey: "textColor")
    }
    
    private func configureLayer() {
        layer.borderColor = UIColor.provedItOrangeColor().cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}
