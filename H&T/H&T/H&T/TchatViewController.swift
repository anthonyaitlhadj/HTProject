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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        getAllUsersToMessageWith()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("******************************************")
        print("Nombre de users: \(users!.count)")
        print("******************************************")
        tableView.reloadData()
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
                        /*let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as AnyObject
                        let usersCount = myJson.count!
                        var index = 0
                        while index < usersCount{
                            if let user = myJson[index] as? NSDictionary{
                                /*let lastname = user["lastname"]!
                                self.users.updateValue(lastname, forKey: index)
                                
                                let firstname = user["firstname"]!
                                self.users.updateValue(firstname, forKey: "firstname")*/
                                
                                let username = user["username"]!
                                self.users[index] = username
                                print("Dictionary: \(self.users.values)")
                            }
                            index = index+1
                        }*/
                        let myJson = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as! [String:AnyObject]
                        if let usersFromJson = myJson["users"] as? [[String:AnyObject]]{
                            for userFromJson in usersFromJson{
                                let user = User()
                                if let firstname = userFromJson["firstname"] as? String, let lastname = userFromJson["lastname"] as? String, let username = userFromJson["username"] as? String{
                                    user.firstname = firstname
                                    user.lastname = lastname
                                    user.username = username
                                    print("******************************************")
                                    print("Firstname: \(user.firstname!)")
                                    print("Lasstname: \(user.lastname!)")
                                    print("username: \(user.username!)")
                                    print("******************************************")
                                }
                                self.users?.append(user)
                            }
                        }
                        self.tableView.reloadData()
                    }catch{
                        print("******************************************")
                        print("Error caught on: \(error)")
                        print("******************************************")
                    }

                }
            }
        }
        task.resume()

        /*do{
            let dataToRetrieve = try Data(contentsOf: url)
            users = try JSONSerialization.jsonObject(with: dataToRetrieve, options: .mutableContainers) as! NSArray
            print("******************************************")
            print("Il y a \(users.count) users")
            print("******************************************")
            //print(users[0])
            for user in users {
                print("User found !")
                print(user)
            }
            
        }catch{
            print("******************************************")
            print("Erreur: \(error.localizedDescription)")
            print("******************************************")
        }*/
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectedUsers", for: indexPath) as! SpecialTableViewCell
        //let userCount = users.count
        //var indexes = 0
        print("******************************************")
        print("User: \(users?.count)")
        print("******************************************")
        /*while indexes < userCount {
            /*cell.textLabel?.text = "Nom"//mainData[index] as! String?
            cell.imageView?.image = UIImage(named: "user_male")*/
            cell.imgView.image = UIImage(named: "user_male")
            cell.usernameLabel.text = "USERNAME"//mainData[indexes] as! String
            indexes = indexes+1
        }*/
        //cell.imgView.image = UIImage(named: "user_male")
        //cell.usernameLabel.text = "USERNAME"
        cell.usernameLabel.text = self.users?[indexPath.item].username
        cell.imgView.image = UIImage(named: "user_male")
        cell.lastMessageLabel.text = "Salut"
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
