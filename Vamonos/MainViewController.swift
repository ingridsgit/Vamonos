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
    var returnDate: Date?
    
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var pickWayDateButton: UIButton!
    @IBOutlet weak var pickReturnDateButton: UIButton!
    @IBOutlet weak var returnEnabledToggle: UISwitch!
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true
        searchButton.layer.cornerRadius = 15
        setBudgetLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setReturnEnabled()
        setButtonDates()
        
    }
   
    @IBAction func onAirportButtonClicked(_ sender: Any) {
        let airportVC = self.storyboard?.instantiateViewController(withIdentifier: "airportVC") as! AirportViewController
        airportVC.modalPresentationStyle = UIModalPresentationStyle.currentContext
        present(airportVC, animated: true, completion: nil)
    }
    
    func setButtonDates(){
        if let departureDate = departureDate {
            self.pickWayDateButton.setTitle(DateModel.dateWithTimeZone(date: departureDate, timeZoneAbbr: "CEST"), for: .normal)
        }
        if let returnDate = returnDate {
            self.pickReturnDateButton.setTitle(DateModel.dateWithTimeZone(date: returnDate, timeZoneAbbr: "CEST"), for: .normal)
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
        default:
            pickReturnDateButton.isEnabled = false
            pickReturnDateButton.isUserInteractionEnabled = false
        }
    }
    
    func setBudgetLabel(){
        let sliderValue: Float = budgetSlider.value
        let budget = Int(sliderValue)
        budgetLabel.text = "\(budget) €"
    }
    
    @IBAction func onSliderTouched(_ sender: Any) {
        setBudgetLabel()
    }
    
    @IBAction func onPickDateClicked(_ sender: UIButton) {
        let calendarVC = self.storyboard?.instantiateViewController(withIdentifier: "calendarVC") as! CalendarViewController
        calendarVC.modalPresentationStyle = UIModalPresentationStyle.currentContext
        switch sender {
        case pickReturnDateButton:
            calendarVC.dateMode = DateMode.Return
        default:
            calendarVC.dateMode = DateMode.Way
        }
        
        present(calendarVC, animated: true, completion: nil)
    }
    

    @IBAction func onPassengerButtonClicked(_ sender: UIButton) {
        let passengerVC = self.storyboard?.instantiateViewController(withIdentifier: "passengerVC") as! PassengerViewController
        passengerVC.modalPresentationStyle = UIModalPresentationStyle.currentContext
        present(passengerVC, animated: true, completion: nil)
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
