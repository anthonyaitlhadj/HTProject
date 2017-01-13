//
//  TalkingViewController.swift
//  H&T
//
//  Created by Quentin Kabasele on 11/01/2017.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class TalkingViewController: UIViewController {
    let userInfo: UserDefaults = UserDefaults.standard
    @IBOutlet weak var messageToSend: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        retreivingAllMessages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendingMessage(_ sender: AnyObject) {
        sendMessage()
    }
    
    func sendMessage(){
        let url = URL(string: "http://localhost:8888/H&T/insertMessage.php")!
        var request = URLRequest(url: url)
        let message = messageToSend.text!
        let sender_id = userInfo.value(forKey: "ID")!
        
        //STEP2 : Méthode que l'on utilise ==> method POST
        request.httpMethod = "POST"
        
        //STEP3 : body rattaché à l'url
        let body = "sending_username_id=\(sender_id)&message=\(message)&receiving_username_id=\(8)"
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil{
                //Préparation de la requête
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parseJson = json else{
                        print("************************************")
                        print("Error while parsing: \(error)")
                        return
                    }
                    print("************************************")
                    print(parseJson)
                    
                }catch{
                    print("************************************")
                    print("Caught an error \(error)")
                }
            }else{
                print("Error: \(error)")
            }
        })
        //Lancement de la requête
        task.resume()
    }
    
    func retreivingAllMessages(){
        
    }
}
