//
//  Airport.swift
//  Vamonos
//
//  Created by Admin on 20/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class Airport : Object {
    
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var latitde: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var cityCode: String = ""
    @objc dynamic var countryCode: String = ""
    
//    convenience init(code: String,name: String, coordinates: [Double], cityCode: String, countryCode: String) {
//        self.code = code
//        self.name = name
//        self.coordinates = coordinates
//        self.cityCode = cityCode
//        self.countryCode = countryCode
//    }
    
}
