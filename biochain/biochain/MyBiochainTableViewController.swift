//
//  MyBiochainTableViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 10/30/22.
//

import Foundation
import UIKit

class MyBiochainCell: UITableViewCell {

    @IBOutlet weak var ph: UILabel!
    
    @IBOutlet weak var data: UILabel!
    
    @IBOutlet weak var ch: UILabel!
    
    @IBOutlet weak var ts: UILabel!
    
    
    
}
class MyBiochainTableViewController: UITableViewController {
    
    @IBOutlet var mybiochainTableView: UITableView!
    
    var responseDictionaryArray: [[String:AnyObject]]? = []
    
    let countries = ["1", "2", "3"]
    var biochainUserId = "BCU-1"

    override func viewDidLoad() {
       super.viewDidLoad()
        
//       self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
//
        
        self.mybiochainTableView.dataSource = self
        self.mybiochainTableView.delegate = self
        configureRefreshControl()
    }
    
    func configureRefreshControl () {
       // Add the refresh control to your UIScrollView object.
       self.refreshControl = UIRefreshControl()
       self.refreshControl?.addTarget(self, action:
                                          #selector(handleRefreshControl),
                                          for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
       // Update your content…
        loadData()
       // Dismiss the refresh control.
       DispatchQueue.main.async {
          self.refreshControl?.endRefreshing()
       }
    }

    
//    @objc func refresh(_ sender: AnyObject) {
//
//        self.tableView.reloadData()
//        self.refreshControl?.endRefreshing()
//    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rowCount = responseDictionaryArray?.count {
            return rowCount;
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewCell: UITableViewCell?
        
 
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "mybiochaincell", for: indexPath) as! MyBiochainCell
        let rowNumber : Int = indexPath.row
        guard let responseDictionary = responseDictionaryArray?[rowNumber] else {
            return cell;
        }
            cell.ph.text = responseDictionary["previousHash"] as! String
            cell.data.text = responseDictionary["data"] as! String
            cell.ch.text =  responseDictionary["hash"] as! String
            cell.ts.text = String(responseDictionary["timeStamp"] as! Int)
            viewCell = cell;
        


        return viewCell!
    }
    
    
    
    func loadData() {
        // prepare json data
        let json: [String: Any] = [:]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
//        let url = URL(string: "http://localhost:8080/biochain/patients/saireddyd")!
        let url = URL(string: "http://192.168.68.121:8080/patients/biochain/bioblocks/fetchby/saidorasani")!
    
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
                            print(dictionary["hash"]!)
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
