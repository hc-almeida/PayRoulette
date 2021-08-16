//
//  UITableViewCell+Extensions.swift
//  PayRoulette
//
//  Created by Hellen on 09/08/21.
//

import UIKit

extension UITableViewCell {
    
    static func registerOn(_ tableView: UITableView) {
        let reuseIdentifier = String(describing: self.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: Bundle(for: self.self))
        tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
    }
    
    static func registerCellOn(_ tableView: UITableView) {
        let reuseIdentifier = String(describing: self.self)
        tableView.register(self.self, forCellReuseIdentifier:  reuseIdentifier)
    }
}
