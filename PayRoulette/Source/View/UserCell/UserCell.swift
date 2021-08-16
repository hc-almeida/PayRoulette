//
//  UserCell.swift
//  PayRoulette
//
//  Created by Hellen on 09/08/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Public Properties
    
    class var identifier: String {
        String(describing: UserCell.self)
    }
    
    // MARK: - Public Functions
    
    func setup(user: User) {
        nameLabel.text = user.name
        userImage.image = user.image
    }
}
