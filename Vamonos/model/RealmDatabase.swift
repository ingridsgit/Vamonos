//
//  RealmDatabase.swift
//  Vamonos
//
//  Created by Admin on 20/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabase {
    
    private static var instance: RealmDatabase? = nil
    var database: Realm?
    
    static func getInstance() -> RealmDatabase {
        if self.instance == nil {
            self.instance = RealmDatabase()
        }
        return self.instance!
    }
    
   
    
    private init() {
        
    }
    
}
