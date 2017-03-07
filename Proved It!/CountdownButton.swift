//
//  CountdownButton.swift
//  Proved It!
//
//  Created by Dallas Edwards on 10/23/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class CountdownButton: UIButton {
    private var user: User?
    private var timer: Timer?
    private var isDisplayingCountdown: Bool = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureLayer()
    }
    
    func configure(with user: User) {
        configureView()
        configureLayer()
        configureTimer()
        
        self.user = user
    }

    private func configureView() {
        backgroundColor = UIColor.clear
        titleLabel?.font = UIFont.systemFont(ofSize: 29, weight: UIFontWeightUltraLight)
        
        setTitle("--", for: .normal)
        setTitleColor(UIColor.white, for: .normal)
    }
    
    private func configureLayer() {
        layer.borderColor = UIColor.provedItGreenColor().cgColor
        layer.borderWidth = 2
        layer.cornerRadius = bounds.width / 2
    }
    
    private func configureTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: updateTitleLabel)
        timer?.fire()
    }
    
    private func updateTitleLabel(with timer: Timer) {
        guard let configuration = user?.configuration else {
            return
        }
        
        if configuration.isTargetDateInFuture {
            if !isDisplayingCountdown {
                UIView.transition(with: self,
                                  duration: Constants.CountdownButton.FlipAnimationDuration,
                                  options: .transitionFlipFromRight,
                                  animations: { self.setTitle(configuration.formattedTimeUntilTargetDate, for: .normal) },
                                  completion: nil)
                
                isDisplayingCountdown = true
            } else {
                setTitle(configuration.formattedTimeUntilTargetDate, for: .normal)
            }
        } else if isDisplayingCountdown {
            UIView.transition(with: self,
                              duration: Constants.CountdownButton.FlipAnimationDuration,
                              options: .transitionFlipFromLeft,
                              animations: { self.setTitle("Prove it!", for: .normal) },
                              completion: nil)
            
            isDisplayingCountdown = false
        }
    }
}
