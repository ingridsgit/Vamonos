//
//  APIRequests.swift
//  Vamonos
//
//  Created by Admin on 14/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Alamofire
import MapKit


class APIRequests {
    static let API_KEY = "1d82d8fede2d239756a91ef78bfb601a"
    
    
    static func searchCityByName(input: String, resultHandler: @escaping ([String])->Void){
    
        let parameters: Parameters = ["term": input]
        let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
        let myRequest = Alamofire.request("https://nano.aviasales.ru/places_en", parameters: parameters, headers: headers)
        myRequest.responseJSON(completionHandler: {(dataResponse) in
            if dataResponse.result.isSuccess {
                if let rootArray = dataResponse.result.value as? [[String:Any]] {
                    var cityList:[String] = []
                    for array in rootArray {
                        if let name = array["name"] as? String {
                            cityList.append(name)
                        }
                    }
                    resultHandler(cityList)
                }
            }
        })
    }
    
    static func convertStringToCoordinates(string: String) -> CLLocationCoordinate2D? {
        var coordinates: CLLocationCoordinate2D? = nil
        let coordinatesSplit = string.split(separator: ":")
        if let longitude = Double(coordinatesSplit[0]),
            let latitude = Double(coordinatesSplit[1]){
            coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
        return coordinates
    }
    
    static func setMapToUserLocation(mapView: MKMapView){
        let parameters: Parameters = ["locale": "en", "callback": "useriata"]
        let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
        let myRequest = Alamofire.request("https://www.travelpayouts.com/whereami?locale=fr&callback=", parameters: parameters, headers: headers)
        myRequest.responseJSON(completionHandler: {(dataResponse) in
            if dataResponse.result.isSuccess {
                if let rootArray = dataResponse.result.value as? [String:Any],
                   let coordinateString = rootArray["coordinates"] as? String,
                    let coordinates = convertStringToCoordinates(string: coordinateString) {
                            mapView.centerCoordinate = coordinates
                            print(coordinates)
                        }
            } else {
                print(dataResponse.result.debugDescription)
            }
        })
    }
    
}
