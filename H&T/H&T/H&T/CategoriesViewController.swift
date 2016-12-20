//
//  CategoriesViewController.swift
//  H&T
//
//  Created by Quentin Kabasele on 20/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    let userInfo: UserDefaults = UserDefaults.standard
    @IBOutlet weak var userInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.userInfoLabel.text = userInfo.value(forKey: "Pseudo") as! String?
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signout(_ sender: AnyObject) {
        let appDomain = Bundle.main.bundleIdentifier
        UserDefaults.standard.removePersistentDomain(forName: appDomain!)
        self.performSegue(withIdentifier: "SignOut", sender: self)
    }
}
