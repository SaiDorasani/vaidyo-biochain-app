//
//  MyBioTableViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 10/30/22.
//

import Foundation
import UIKit
class MyBioCell: UITableViewCell {
    
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var dob: UILabel!

    @IBOutlet weak var gender: UILabel!
}

class MyBioCard: UITableViewCell {
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var username: UILabel!
    
}

class MyBioHealth: UITableViewCell {
    
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var bp: UILabel!
    @IBOutlet weak var oxygenPercent: UILabel!
}
class MyBioTableViewController: UITableViewController {
    
    @IBOutlet var myBioTableView: UITableView!
    var responseDictionaryArray: [[String:AnyObject]] = []
    
    let countries = ["1", "2", "3"]
    var biochainUserId = "BCU-1"

    override func viewDidLoad() {
       super.viewDidLoad()
       self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        myBioTableView.delegate = self
        myBioTableView.dataSource = self
        
//       refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//       refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//       tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewCell: UITableViewCell?
        
        if(indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "mybiocell", for: indexPath) as! MyBioCell
           //cell.lastName.text = "hell"

   //        let country = countries[indexPath.row]
   //        cell.textLabel?.text = country.name
   //        cell.detailTextLabel?.text = country.isoCode
   //        cell.imageView?.image = UIImage(named: country.isoCode)
           if let responseDictionary = responseDictionaryArray.first {
               cell.firstName.text = responseDictionary["firstName"] as! String
               cell.lastName.text = responseDictionary["lastName"] as! String
               cell.dob.text =  responseDictionary["dateOfBirth"] as! String
               cell.gender.text = responseDictionary["gender"] as! String
           }
          
            viewCell = cell;
        }
        
        if(indexPath.row == 1)
        {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "mybiocard", for: indexPath) as! MyBioCard
           //cell.lastName.text = "hell"

   //        let country = countries[indexPath.row]
   //        cell.textLabel?.text = country.name
   //        cell.detailTextLabel?.text = country.isoCode
   //        cell.imageView?.image = UIImage(named: country.isoCode)
           if let responseDictionary = responseDictionaryArray.first {
               cell2.username.text = responseDictionary["username"] as! String
               cell2.userId.text = responseDictionary["userId"] as! String
            
           }
            cell2.isHidden = false;
            viewCell = cell2;
        }
        
        if(indexPath.row == 2)
        {
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "mybiohealth", for: indexPath) as! MyBioHealth
           //cell.lastName.text = "hell"

   //        let country = countries[indexPath.row]
   //        cell.textLabel?.text = country.name
   //        cell.detailTextLabel?.text = country.isoCode
   //        cell.imageView?.image = UIImage(named: country.isoCode)
           if let responseDictionary = responseDictionaryArray.first {
               cell3.height.text = (responseDictionary["height"] as? String)
               cell3.weight.text = responseDictionary["weight"] as? String
               cell3.bp.text = responseDictionary["bp"] as? String
               cell3.oxygenPercent.text = responseDictionary["oxygenPercent"] as? String
            
           }
            cell3.isHidden = false;
            viewCell = cell3;
        }


        return viewCell!
    }

    @objc func refresh(_ sender: AnyObject) {
        
        
       // Code to refresh table view
        self.tableView.reloadData()
//        self.refreshControl?.endRefreshing()
        loadData();
    }
    
    func loadData() {
        // prepare json data
        let json: [String: Any] = [:]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "http://localhost:8080/biochain/patients/saireddyd")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        // insert json data to the request
        //request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");

        let task = URLSession.shared.dataTask(with: request) { [self] data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
    
            if let arry = responseJSON as? [[String:AnyObject]] {
                self.responseDictionaryArray = arry;
                     for dictionary in arry {
                            print(dictionary["username"]!)
                        }
                DispatchQueue.main.async {
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                   }
                
            }
            
            if let responseJSON = responseJSON as? [String: Any] {
                
                print(responseJSON)
            }
        }

        task.resume()
    } //enddata load
}


