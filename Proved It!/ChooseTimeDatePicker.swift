//
//  ChooseTimeDatePicker.swift
//  Proved It!
//
//  Created by Dallas Edwards on 10/2/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class ChooseTimeDatePicker: UIDatePicker {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        configureView()
        configureLayer()
    }
    
    private func configureView() {
        backgroundColor = UIColor.clear
        
        setValue(UIColor.white, forKey: "textColor")
    }
    
    private func configureLayer() {
        layer.borderColor = UIColor.provedItOrangeColor().cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.width / 2
    }
}
