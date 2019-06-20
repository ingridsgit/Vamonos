//
//  City.swift
//  Vamonos
//
//  Created by Admin on 20/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class City : Object {
    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""
    var airportList = List<Airport>()
    
    override static func primaryKey() -> String? {
        return "code"
    }
}
