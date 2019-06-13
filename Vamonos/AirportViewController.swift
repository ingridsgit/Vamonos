//
//  AirportViewController.swift
//  Vamonos
//
//  Created by Admin on 13/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class AirportViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func onSearchClicked(_ sender: Any) {
        if let input = searchField.text {
            let parameters: Parameters = ["term": input]
            let myRequest = Alamofire.request("http://nano.aviasales.ru/places_fr", parameters: parameters)
            myRequest.responseJSON(completionHandler: { (dataResponse) in
                if dataResponse.result.isSuccess {
                    if let rootArray = dataResponse.result.value as? [Any] {
//                        print(rootArray[0].description)
                    }
                }
            })
            
            
            
        }
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
