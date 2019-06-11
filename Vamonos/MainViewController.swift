//
//  MainViewController.swift
//  Vamonos
//
//  Created by Admin on 11/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    
    var departureDate: Date?
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var pickWayDateButton: UIButton!
    @IBOutlet weak var pickReturnDateButton: UIButton!
    @IBOutlet weak var returnEnabledToggle: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setReturnEnabled()
        if let departureDate = departureDate {
                self.pickWayDateButton.titleLabel?.text = DateModel.dateWithTimeZone(date: departureDate, timeZoneAbbr: "CEST")
        }
        
    }
    
    @IBAction func onReturnToggleClicked(_ sender: Any) {
        setReturnEnabled()
    }
    
    func setReturnEnabled(){
        switch returnEnabledToggle.isOn {
        case true:
            pickReturnDateButton.isEnabled = true
            pickReturnDateButton.isUserInteractionEnabled = true
            print("on")
        default:
            pickReturnDateButton.isEnabled = false
            pickReturnDateButton.isUserInteractionEnabled = false
            print("off")
        }
    }
    
    @IBAction func onPickDateClicked(_ sender: Any) {
        let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "calendarVC") as! ViewController
        calendarVC.modalPresentationStyle = UIModalPresentationStyle.currentContext
        present(calendarVC, animated: true, completion: nil)
    }
    
    @IBAction func onSearchClicked(_ sender: Any) {
        let myRequest = Alamofire.request("https://jsonplaceholder.typicode.com/todos")
        myRequest.responseJSON(completionHandler: { (dataResponse) in
            if dataResponse.result.isSuccess {
                if let rootArray = dataResponse.result.value as? [[String:Any]] {
                    for array in rootArray {
                            if let title = array["title"] as? String {
                                print(title)
                            }
                    }
                }
            }
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
