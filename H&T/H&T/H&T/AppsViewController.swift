//
//  AppsViewController.swift
//  H&T
//
//  Created by Anthony Ait Lhadj on 08/01/16.
//  Copyright © 2016 Developers Academy. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
 
    var apps = AllApps.getAllApps()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.dataSource = self
        tableView.estimatedRowHeight = 376
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.reloadData()
    }
}

extension AppsViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return apps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AppCell") as! AppTableViewCell
        let app = apps[indexPath.row]
        
        cell.app = app
        
        return cell
    }
}
















