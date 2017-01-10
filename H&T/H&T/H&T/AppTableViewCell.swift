//
//  AppTableViewCell.swift
//  H&T
//
//  Created by Anthony Ait Lhadj on 08/01/16.
//  Copyright © 2016 Developers Academy. All rights reserved.
//

import UIKit

class AppTableViewCell: UITableViewCell
{
    @IBOutlet weak var appImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    
    var app: App! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        appImageView.image = UIImage(named: app.imageName)
        appNameLabel.text = app.name
        
        appNameLabel.layer.shadowColor = UIColor.black.cgColor
        appNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        appNameLabel.layer.shadowRadius = 6
        appNameLabel.layer.shadowOpacity = 1
    }
}
























