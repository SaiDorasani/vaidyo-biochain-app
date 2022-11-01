//
//  MyRewardsTableViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 10/30/22.
//

import Foundation
import UIKit

class MyRewardsViewCell : UITableViewCell {
    
}

class MyRewardsTableViewController: UITableViewController {
    

    @IBOutlet var myrewardsTableViewController: UITableView!
    
    

    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        myrewardsTableViewController.delegate = self
        myrewardsTableViewController.dataSource = self
       
    }
    
    @objc func refresh(_ sender: AnyObject) {
        
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewCell: UITableViewCell?
        
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myrewardscell", for: indexPath) as! MyRewardsViewCell
         
          
            viewCell = cell;
        }


        return viewCell!
    }
}
