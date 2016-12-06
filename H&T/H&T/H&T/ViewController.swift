//
//  ViewController.swift
//  H&T
//
//  Created by Developer on 06/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func goToSignUpView(_ sender: UIButton) {
        //performSegue(withIdentifier: "SignUp", sender: self)
    }
    
    @IBAction func goToSignInView(_ sender: UIButton) {
        //performSegue(withIdentifier: "SignIn", sender: self)
    }
    
}

