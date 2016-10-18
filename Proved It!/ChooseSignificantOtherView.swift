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
    func chooseSignificantOtherView(_ chooseSignificantOtherView: ChooseSignificantOtherView, didChooseContactWith name: String, phoneNumbers: [String])
}

final class ChooseSignificantOtherView: BaseView {
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ChooseSignificantOtherViewDelegate?

    fileprivate var contacts: [CNContact]?
    
    override func awakeFromNib() {
        configureRegisteredCells()
        configureTableView()
    }
    
    func configure(using contacts: [CNContact]) {
        self.contacts = contacts
    }

    private func configureRegisteredCells() {
        let cellName = String(describing: ChooseSignificantOtherCell.self)
        let nib = UINib(nibName: cellName, bundle: nil)

        tableView.register(nib, forCellReuseIdentifier: cellName)
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.2)
        tableView.tableFooterView = UIView()
    }
}

extension ChooseSignificantOtherView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: String(describing: ChooseSignificantOtherCell.self), for: indexPath)
    }
}

extension ChooseSignificantOtherView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ChooseSignificantOtherCell, let contacts = contacts else {
            return
        }

        cell.configure(using: contacts[(indexPath as NSIndexPath).row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let contacts = contacts, 0..<contacts.count ~= (indexPath as NSIndexPath).row else {
            return
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? ChooseSignificantOtherCell else {
            return
        }
        
        guard let name = cell.name, let phoneNumbers = cell.phoneNumbers else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.chooseSignificantOtherView(self, didChooseContactWith: name, phoneNumbers: phoneNumbers)
    }
}
