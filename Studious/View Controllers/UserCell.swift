//
//  UserCell.swift
//  Studious
//
//  Created by Daniel Ankunda on 4/1/20.
//  Copyright © 2020 Daniel Ankunda. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var majorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
