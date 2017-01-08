//
//  SignInViewController.swift
//  H&T
//
//  Created by Developer on 06/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    let userInfo: UserDefaults = UserDefaults.standard
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let userLogged:Int = userInfo.integer(forKey: "estCo") as Int
        
        if userLogged == 1 {
            print("LoggedIn : \(userLogged)")
            self.performSegue(withIdentifier: "goToCategories", sender: self)
        }
    }
    

    @IBAction func loginAction(_ sender: AnyObject) {
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        {
            
            usernameTextField.attributedPlaceholder = NSAttributedString(string: "Pseudo", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
        }else{
            let url = URL(string: "http://localhost:8888/H&T/login.php")!
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            let body = "username=\(usernameTextField.text!.lowercased())&password=\(passwordTextField.text!)"
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error == nil{
                    //Préparation de la requête
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        guard let parseJson = json else{
                            print("************************************")
                            print("Error while parsing")
                            return
                        }
                        
                        let id = parseJson["id"]
                        print("parseJSON: \(id)")
                        if id != nil{
                            print("************************************")
                            print(parseJson)
                            
                            let username = parseJson["username"] as! String
                            let firstname = parseJson["firstname"] as! String
                            let lastname = parseJson["lastname"] as! String
                            
                            self.userInfo.setValue(id, forKey: "ID")
                            self.userInfo.setValue(username, forKey: "Pseudo")
                            self.userInfo.setValue(firstname, forKey: "Prenom")
                            self.userInfo.setValue(lastname, forKey: "Nom")
                            self.userInfo.setValue(1, forKey: "estCo")
                            self.userInfo.synchronize()
                        }
                        
                    }catch{
                        print("************************************")
                        print("Caught an error \(error)")
                    }
                }else{
                    print("Error: \(error)")
                }
                //Lancement de la requête
            }).resume()
            self.performSegue(withIdentifier: "goToCategories", sender: self)
            
        }
    }
}
