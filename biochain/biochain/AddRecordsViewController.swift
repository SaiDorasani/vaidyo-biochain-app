//
//  AddRecordsViewController.swift
//  biochain
//
//  Created by Keertika Asesa on 11/1/22.
//

import Foundation
import UIKit

class AddInsuranceView: UIView {
    @IBOutlet weak var insuranceName: UITextField!
    @IBOutlet weak var insuranceID: UITextField!
    
}

class BookAppointment: UIView {
    @IBOutlet weak var reasonForVisit: UITextField!
}

class AddRecordsViewController: UIViewController {
    
    @IBOutlet weak var addInsuranceView: AddInsuranceView!
    
    @IBOutlet weak var YouaregoodtogoView: UIView!
    
    @IBOutlet weak var bookAppointmentView: BookAppointment!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view,
        action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func submitInsuranceToBiochain(_ sender: Any) {
        //submit insurance information to biochain
        var insruanceName = "" + addInsuranceView.insuranceName.text!;
        var inseruanceId = "" + addInsuranceView.insuranceID.text!;
        
        var insuranceInfo = insruanceName + inseruanceId;
        
        let json: [String: Any] = ["key": "insurance", "value" : insuranceInfo, "userId" : "BCU-1"]
        postAction(json)
        addInsuranceView.isHidden = true
        
    }
    
    @IBAction func bookAnAppointment(_ sender: Any) {
        var doctorName = "Doctor: Tanish Asesa";
        var appointmentTime = "Appointment Time: Nov 1, 2022, 4 pm CST";
        var reasonForVisit = "Reason for Visit: " + bookAppointmentView.reasonForVisit.text!
        
        var bookingInfo = doctorName + "| " + appointmentTime + "| " + reasonForVisit;
        
        let json: [String: Any] = ["key": "boookingInfo", "value" : bookingInfo, "userId" : "BCU-1"]
        postAction(json)
        bookAppointmentView.isHidden = true
        YouaregoodtogoView.isHidden = false;
        
        
    }
    
    
    func postAction(_ jsonPayload: [String: Any]) {
        
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonPayload)

        // create post request
        let url = URL(string: "http://192.168.68.121:8080/patients/biochain/bioblocks/create/saidorasani")!
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
            
            //self.addInsuranceView.isHidden = true
            
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }

        task.resume()
        
    }
    
}
