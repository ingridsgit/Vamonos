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
import RealmSwift


class APIRequests {
    static let API_KEY = "1d82d8fede2d239756a91ef78bfb601a"
    
    static func getCitiesFromJson(resultHandler: @escaping ([City])->Void){
        let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
        let myRequest = Alamofire.request("https://api.travelpayouts.com/data/cities.json", headers: headers)
        myRequest.responseJSON(completionHandler: {(dataResponse) in
            if dataResponse.result.isSuccess {
                if let rootArray = dataResponse.result.value as? [[String:Any]] {
                    var cityArray: [City] = []
                    for city in rootArray {
                        if let code = city["code"] as? String,
                            let nameTranslation = city["name_translations"] as? [String:String],
                            let name = nameTranslation["en"] {
                            let city = City()
                            city.code = code
                            city.name = name
                            cityArray.append(city)
                            
                        }
                    }
                    resultHandler(cityArray)
                }
            }
        })
        
    }
    
    
    static func searchAirportbyName(input: String, resultHandler: @escaping ([String])->Void){
        if let database = try? Realm() {
            var airportNames: [String] = []
            let airportList = database.objects(Airport.self).filter("(name CONTAINS[c] %@) OR (cityName CONTAINS[c] %@)", input, input)
            for airport in airportList {
                airportNames.append(airport.name)
            }
            resultHandler(airportNames)
        }
    }
    
    static func getAirportListFromJson(cities: [City], resultHandler: @escaping ([Airport])->Void){
        let headers : HTTPHeaders = ["x-access-token": APIRequests.API_KEY]
        let myRequest = Alamofire.request("https://api.travelpayouts.com/data/airports.json", headers: headers)
        myRequest.responseJSON(completionHandler: {(dataResponse) in
            if dataResponse.result.isSuccess {
                if let rootArray = dataResponse.result.value as? [[String:Any]],
                    let database = try? Realm() {
                    var airportArray: [Airport] = []
                    for array in rootArray {
                        if let code = array["code"] as? String,
                            let flightable = array["flightable"] as? Bool,
                            flightable == true,
                            let nameTranslation = array["name_translations"] as? [String:String],
                            let name = nameTranslation["en"],
                            let coordinates = array["coordinates"] as? [String:Double],
                            let longitude = coordinates["lon"],
                            let latitude = coordinates["lat"],
                            let cityCode = array["city_code"] as? String,
                            let countryCode = array["country_code"] as? String {
                            let airport = Airport()
                            airport.code = code
                            airport.name = name
                            airport.longitude = longitude
                            airport.latitde = latitude
                            airport.cityCode = cityCode
                            let cityWithCode = database.object(ofType: City.self, forPrimaryKey: cityCode)
                            airport.cityName = cityWithCode?.name ?? ""
                            airport.countryCode = countryCode
                            airportArray.append(airport)
                        }
                    }
                    resultHandler(airportArray)
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
