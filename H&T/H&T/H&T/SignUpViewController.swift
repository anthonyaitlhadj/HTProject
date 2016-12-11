//
//  SignUpViewController.swift
//  H&T
//
//  Created by Developer on 06/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit


class SignUpViewController: UIViewController {

    
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var pseudoTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerAction(_ sender: AnyObject) {
        //Si les champs sont vides
        if lastnameTextField.text!.isEmpty || firstnameTextField.text!.isEmpty || pseudoTextField.text!.isEmpty || passwordTextField.text!.isEmpty || confirmPasswordTextField.text!.isEmpty{
            //On metles placeholders en rouge
            lastnameTextField.attributedPlaceholder = NSAttributedString(string: "Nom", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            firstnameTextField.attributedPlaceholder = NSAttributedString(string: "Prénom", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            pseudoTextField.attributedPlaceholder = NSAttributedString(string: "Pseudo", attributes: [NSForegroundColorAttributeName: UIColor.red])
            emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            passwordTextField.attributedPlaceholder = NSAttributedString(string: "Mot de passe", attributes: [NSForegroundColorAttributeName: UIColor.red])
            
            confirmPasswordTextField.attributedPlaceholder = NSAttributedString(string: "Confirmaion du mot de passe", attributes: [NSForegroundColorAttributeName: UIColor.red])
        }else{
            //Créer un user dans la base de donnée HT
            
            //STEP1 : url de register.php
            let url = URL(string: "http://localhost:8888/H&T/register.php")!
            var request = URLRequest(url: url)
            
            //STEP2 : Méthode que l'on utilise ==> method POST
            request.httpMethod = "POST"
            
            //STEP3 : body rattaché à l'url
            let body = "username=\(pseudoTextField.text!.lowercased())&password=\(passwordTextField.text!)&email=\(emailTextField.text!)&firstname=\(firstnameTextField.text!)&lastname=\(lastnameTextField.text!)"
            request.httpBody = body.data(using: String.Encoding.utf8)
            
            
            //STEP4 : lancement de la requête
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
            
            
        }
    }
}
