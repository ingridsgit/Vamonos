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
    
    override func viewWillAppear(_ animated: Bool) {
        setMapToUserLocation()
        
}
    
    func setMapToUserLocation(){
        let parameters: Parameters = ["locale": "fr", "callback": "useriata"]
        let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
        let myRequest = Alamofire.request("https://www.travelpayouts.com/whereami?locale=fr&callback=", parameters: parameters, headers: headers)
        myRequest.responseJSON(completionHandler: { (dataResponse) in
            if dataResponse.result.isSuccess {
                print(dataResponse.result.value)
                if let rootArray = dataResponse.result.value as? [String:Any] {
                    if let coordinateString = rootArray["coordinates"] as? String {
                        let coordinatesSplit = coordinateString.split(separator: ":")
                        if let latitude = Double(coordinatesSplit[0]),
                            let longitude = Double(coordinatesSplit[1]){
                        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                            self.mapView.centerCoordinate = coordinates
                        }
                    }
                    ajouter weak self
                }
            }
            else {
                print(dataResponse.result.debugDescription)
            }
        })
    }
    
    @IBAction func onSearchClicked(_ sender: Any) {
        if let input = searchField.text {
            let parameters: Parameters = ["term": input]
            let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
            let myRequest = Alamofire.request("https://nano.aviasales.ru/places_en", parameters: parameters, headers: headers)
            myRequest.responseJSON(completionHandler: { (dataResponse) in
                if dataResponse.result.isSuccess {
                    if let rootArray = dataResponse.result.value as? [[String:Any]] {
                        for array in rootArray {
//                            if let title = array["title"] as? String {
//                                print(title)
//                            }
                            print(array.description)
                        }
                    }
                }
                else {
                    print(dataResponse.result.debugDescription)
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
