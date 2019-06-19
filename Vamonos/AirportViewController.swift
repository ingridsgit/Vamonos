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

class AirportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var cs_tableHeight: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var autoFillTableView: UITableView!
    var _cityList: [String] = []
    var cellHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        autoFillTableView.dataSource = self
        autoFillTableView.delegate = self
        autoFillTableView.isHidden = true
        

    }
    
    @objc func inputDidChange(){
        if let input = searchField.text, input.count > 1 {
            APIRequests.searchCityByName(input: input) { (newCityList:[String]) in
                self._cityList = newCityList
                self.autoFillTableView.reloadData()
                self.autoFillTableView.isHidden = false
                
                 // resize tableView
                let maxTableHeight = 896.0 - Double(self.view.safeAreaInsets.top) - Double(self.searchField.frame.maxY) - Double(self.searchField.frame.height)
                let remainder = maxTableHeight.truncatingRemainder(dividingBy: 44.0)
                let height = min(Double(newCityList.count) * 44, Double(maxTableHeight) - remainder)
                self.cs_tableHeight.constant = CGFloat(height)
            }
            print(_cityList.description)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        APIRequests.setMapToUserLocation(mapView: self.mapView)
}
    
    @IBAction func onSearchClicked(_ sender: Any) {
        if let input = searchField.text, input.count > 1 {
            let parameters: Parameters = ["term": input]
            let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
            let myRequest = Alamofire.request("https://nano.aviasales.ru/places_en", parameters: parameters, headers: headers)
            myRequest.responseJSON(completionHandler: { [weak self] (dataResponse) in
                if dataResponse.result.isSuccess {
                    if let rootArray = dataResponse.result.value as? [[String:Any]] {
                        for array in rootArray {
                            if let name = array["name"] as? String {
                                print(name)
                            }
                        }
                    }
                }
                else {
                    print(dataResponse.result.debugDescription)
                }
            })
        }
        searchField.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _cityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchFieldCell", for: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = _cityList[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchField.text = _cityList[indexPath.row]
        tableView.isHidden = true
        searchField.endEditing(true)
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
