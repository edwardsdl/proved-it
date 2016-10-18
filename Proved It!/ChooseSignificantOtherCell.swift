//
//  ChooseSignificantOtherCell.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/18/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

final class ChooseSignificantOtherCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    var name: String?
    var phoneNumbers: [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
    }
    
    func configure(using contact: CNContact) {
        configureName(using: contact)
        configurePhoneNumbers(using: contact)
        configureTextLabel()
        configureDetailTextLabel()
    }
    
    private func configureName(using contact: CNContact) {
        name = CNContactFormatter.string(from: contact, style: .fullName)
    }
    
    private func configurePhoneNumbers(using contact: CNContact) {
        phoneNumbers = contact.phoneNumbers
            .sorted(by: { $0.0.label == CNLabelPhoneNumberMobile })
            .sorted(by: { $0.0.label == CNLabelPhoneNumberiPhone })
            .flatMap({ $0.value })
            .map({ $0.stringValue })
    }
    
    private func configureTextLabel() {
        textLabel?.text = name
    }

    private func configureDetailTextLabel() {
        guard let phoneNumbers = phoneNumbers else {
            return
        }
        
        if phoneNumbers.count == 1 {
            detailTextLabel?.text = phoneNumbers.first
        } else {
            detailTextLabel?.text = "\(phoneNumbers.count) numbers"
        }
    }
}
