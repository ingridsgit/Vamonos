//
//  SearchFieldTableView.swift
//  Vamonos
//
//  Created by Admin on 18/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class CustomSearchField: UITextField {
    
    
    var _tableView: UITableView?
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        _tableView?.removeFromSuperview()
        
    }
   
}

extension CustomSearchField :  {
    
    func updateData(data: [String]){
        _cityList = data
        _tableView?.reloadData()
    }
    
    func setTableView(tableView: UITableView){
        if let tableView = _tableView {
            tableView.dataSource = self
            tableView.delegate = self
            self.window?.addSubview(tableView)
        }
    }
    
  
}
