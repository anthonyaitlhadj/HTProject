//
//  TchatViewController.swift
//  H&T
//
//  Created by Quentin Kabasele on 13/12/2016.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit

class TchatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let userInfo: UserDefaults = UserDefaults.standard
    
    var users: [User]? = []
    var users_id = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getAllUsersToMessageWith()
        //retrieveLastMessage()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("******************************************")
        print("Nombre de users: \(users?.count)")
        print("******************************************")
        tableView.reloadData()
        print("******************************************")
        print("Nombre de users: \(users_id)")
        print("******************************************")
    }
    
    //Affichage de tous les users
    func getAllUsersToMessageWith(){
        let url = URL(string: "http://localhost:8888/H&T/tchatUsers.php")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("******************************************")
                print("Erreur: \(error)")
                print("******************************************")
            }else{
                if let content = data{
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as! [String:AnyObject]
                        print(content)
                        if let usersFromJson = myJson["users"] as? [[String:AnyObject]]{
                            for userFromJson in usersFromJson{
                                let user = User()
                                if let firstname = userFromJson["firstname"] as? String, let user_id = userFromJson["user_id"] as? String, let username = userFromJson["username"] as? String{
                                    user.firstname = firstname
                                    user.user_id = user_id
                                    user.username = username
                                    print("******************************************")
                                    print("Firstname: \(user.firstname!)")
                                    print("User_id: \(user.user_id!)")
                                    print("username: \(user.username!)")
                                    print("******************************************")
                                    self.users_id.append(user.user_id!)
                                }
                                self.users?.append(user)
                            }
                        }
                        //self.tableView.reloadData()
                    }catch{
                        print("******************************************")
                        print("Error caught on: \(error)")
                        print("******************************************")
                    }

                }
            }
        }
        task.resume()
    }
    
    func retrieveLastMessage(){
        let url = URL(string: "http://localhost:8888/H&T/getLastMessage.php")!
        var request = URLRequest(url: url)
        
        //STEP2 : Méthode que l'on utilise ==> method POST
        request.httpMethod = "POST"
        
        //STEP3 : body rattaché à l'url
        let body = "?sending_user_id=\(userInfo.value(forKey: "ID"))&receiving_user_id=\(users_id[3])"
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            if error != nil{
                print("******************************************")
                print("Erreur: \(error)")
                print("******************************************")
            }else{
                do{
                    let myJson = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    guard let parsedJson = myJson else{
                        print("************************************")
                        print("Error while parsing")
                        return
                    }
                    let id = parsedJson["id"]
                    if id != nil{
                        print("************************************")
                        print("Données: \(parsedJson)")
                        print("************************************")
                    }
                }catch{
                    print("******************************************")
                    print("Erreur trouvée :\(error)!!!!")
                    print("******************************************")
                }
            }
        }
        task.resume()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectedUsers", for: indexPath) as! SpecialTableViewCell
        cell.usernameLabel.text = self.users?[indexPath.item].username
        cell.imgView.image = UIImage(named: "user_male")
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
