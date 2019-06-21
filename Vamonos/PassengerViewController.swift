//
//  PassengerViewController.swift
//  Vamonos
//
//  Created by Admin on 13/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class PassengerViewController: UIViewController {

    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var childLabel: UILabel!
    @IBOutlet weak var babyLabel: UILabel!
    @IBOutlet weak var adultStepper: UIStepper!
    @IBOutlet weak var childStepper: UIStepper!
    @IBOutlet weak var babyStepper: UIStepper!
    
    var adultCount = 1
    var childCount = 0
    var babyCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        adultStepper.value = Double(adultCount)
        adultLabel.text = adultCount.description
        childStepper.value = Double(childCount)
        childLabel.text = childCount.description
        babyStepper.value = Double(babyCount)
        babyLabel.text = babyCount.description
    }
    
    @IBAction func onAdultChanged(_ sender: Any) {
        adultCount = Int(adultStepper.value)
        adultLabel.text = adultCount.description
    }
    
    @IBAction func onChildChanged(_ sender: Any) {
        childCount = Int(childStepper.value)
        childLabel.text = childCount.description
    }
    
    @IBAction func onBabyChanged(_ sender: Any) {
        babyCount = Int(babyStepper.value)
        babyLabel.text = babyCount.description
    }
    
    @IBAction func onOkClicked(_ sender: Any) {
        if let mainView = presentingViewController as? MainViewController{
            mainView.adultCount = adultCount
            mainView.childCount = childCount
            mainView.babyCount = babyCount

        }
        dismiss(animated: true, completion: nil)
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
