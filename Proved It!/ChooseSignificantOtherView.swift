//
//  ChooseSignificantOtherView.swift
//  Proved It!
//
//  Created by Dallas Edwards on 2/17/16.
//  Copyright © 2016 Angry Squirrel Software. All rights reserved.
//

import UIKit

final class ChooseSignificantOtherView: BaseView {
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        configureRegisteredCells()
        configureFooter()
    }

    private func configureRegisteredCells() {
        let cellName = String(ChooseSignificantOtherCell)
        let nib = UINib(nibName: cellName, bundle: nil)

        tableView.registerNib(nib, forCellReuseIdentifier: cellName)
    }

    private func configureFooter() {
        tableView.tableFooterView = UIView()
    }
}
