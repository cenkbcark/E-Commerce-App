//
//  ServiceManager.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 9.11.2022.
//

import Foundation
import Firebase

let baseUrl = "https://e-commerceapp-e61d2-default-rtdb.firebaseio.com/"

class DataService {
    static let dataService = DataService()
    
    private var baseRef = Database.database().reference(fromURL: "\(baseUrl)")
    private var itemRef = Database.database().reference(fromURL: "\(baseUrl)/items")
    
    var base_ref : DatabaseReference {
        return baseRef
    }
    var item_ref: DatabaseReference {
        return itemRef
    }
}
