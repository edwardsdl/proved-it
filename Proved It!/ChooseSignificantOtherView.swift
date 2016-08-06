//
//  ChooseSignificantOtherView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import Contacts
import UIKit

protocol ChooseSignificantOtherViewDelegate: class {
    func chooseSignificantOtherView(chooseSignificantOtherView: ChooseSignificantOtherView, didChooseContactWith name: String, phoneNumbers: [String])
}

final class ChooseSignificantOtherView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ChooseSignificantOtherViewDelegate?

    private var contacts: [CNContact]?
    
    override func awakeFromNib() {
        configureRegisteredCells()
        configureTableView()
    }
    
    func configure(using contacts: [CNContact]) {
        self.contacts = contacts
    }

    private func configureRegisteredCells() {
        let cellName = String(ChooseSignificantOtherCell)
        let nib = UINib(nibName: cellName, bundle: nil)

        tableView.registerNib(nib, forCellReuseIdentifier: cellName)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        tableView.tableFooterView = UIView()
    }
}

extension ChooseSignificantOtherView: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(String(ChooseSignificantOtherCell), forIndexPath: indexPath)
    }
}

extension ChooseSignificantOtherView: UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? ChooseSignificantOtherCell, contacts = contacts else {
            return
        }

        cell.configure(using: contacts[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let contacts = contacts where 0..<contacts.count ~= indexPath.row else {
            return
        }
        
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) as? ChooseSignificantOtherCell else {
            return
        }
        
        guard let name = cell.name, phoneNumbers = cell.phoneNumbers else {
            return
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        delegate?.chooseSignificantOtherView(self, didChooseContactWith: name, phoneNumbers: phoneNumbers)
    }
}
