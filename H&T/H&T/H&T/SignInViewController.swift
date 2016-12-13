//
//  SignInViewController.swift
//  H&T
//
//  Created by Developer on 06/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginAction(_ sender: UIButton) {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        {
            
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Pseudo", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
        }else{
            let url = URL(string: "http://localhost:8888/H&T/login.php")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            
            let body = "username=\(usernameTextField.text!.lowercased())"
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data: Data?, response:URLResponse?, error: Error?) in
                if error == nil{
                    //Préparation de la requête
                    DispatchQueue.main.async {
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                            
                            guard let parseJson = json else{
                                print("Error while parsing")
                                return
                            }
                            
                            let id = parseJson["id"]
                            if id != nil{
                                print(parseJson)
                            }
                        }catch{
                            print("Caught an error \(error)")
                        }
                    }
                }else{
                    print("Error: \(error)")
                }
                //Lancement de la requête
            }).resume()
            
            performSegue(withIdentifier: "goToCategories", sender: self)

        }
        
    }
}
