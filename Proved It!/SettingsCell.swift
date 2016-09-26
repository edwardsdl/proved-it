//
//  SettingsCell.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/8/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureDisclosureIndicator()
    }
    
    func configure(with title: String, detail: String) {
        titleLabel.text = title.uppercased()
        detailLabel.text = detail
    }
    
    fileprivate func configureDisclosureIndicator() {
        guard let disclosureIndicator = subviews.flatMap({ $0 as? UIButton }).last else {
            return
        }
        
        disclosureIndicator.frame.origin.x -= 23
    }
}
