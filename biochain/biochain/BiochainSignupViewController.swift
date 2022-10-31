//
//  BiochainSignupViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 10/30/22.
//

import UIKit

class BiochainSignupViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signupLogin(_ sender: Any) {
        
        // prepare json data
        let json: [String: Any] = ["username": username.text,"password" : password.text, "firstName" : firstName.text, "lastName" : lastName.text, "dateOfBirth" : dateOfBirth.text]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        // create post request
        let url = URL(string: "http://localhost:8080/biochain/signup")!
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
        
        
        let mainTabBarController = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController");
        UIApplication.shared.windows.first?.rootViewController = mainTabBarController;
    }
    
}

