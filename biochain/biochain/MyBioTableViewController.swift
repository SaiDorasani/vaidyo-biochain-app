//
//  MyBioTableViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 10/30/22.
//

import Foundation
import UIKit
class MyBioTableViewController: UITableViewController {
    
    let countries = ["1", "2", "3"]
    var biochainUserId = "BCU-1"
    class MyBioCell : UIView {
        
        @IBOutlet weak var firstNameLabel: UILabel!
        @IBOutlet weak var lastNameLabel: UILabel!
        @IBOutlet weak var dateOfBirthLabel: UILabel!
        @IBOutlet weak var genderLabel: UILabel!
        
    }
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
       self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)

//       refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//       refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//       tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mybiocell", for: indexPath)

//        let country = countries[indexPath.row]
//        cell.textLabel?.text = country.name
//        cell.detailTextLabel?.text = country.isoCode
//        cell.imageView?.image = UIImage(named: country.isoCode)

        return cell
    }

    @objc func refresh(_ sender: AnyObject) {
        
        
       // Code to refresh table view
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func loadData() {
        // prepare json data
        let json: [String: Any] = ["username": username.text,"password" : password.text, "firstName" : firstName.text, "lastName" : lastName.text, "dateOfBirth" : dateOfBirth.text]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "http://localhost:8080/biochain/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // insert json data to the request
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type");

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
    } //enddata load
}


