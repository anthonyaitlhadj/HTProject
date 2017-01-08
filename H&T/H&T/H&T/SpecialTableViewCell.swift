//
//  SpecialTableViewCell.swift
//  H&T
//
//  Created by Quentin Kabasele on 30/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class SpecialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
