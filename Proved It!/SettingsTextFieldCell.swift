//
//  SettingsTextFieldCell.swift
//  Proved It!
//
//  Created by Dallas Edwards on 7/8/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class SettingsTextFieldCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailTextField: UITextField!
    
    override func awakeFromNib() {
        backgroundColor = UIColor.clear
    }
    
    func configure(with title: String, detail: String) {
        titleLabel.text = title.uppercased()
        detailTextField.text = detail
    }
}
