//
//  ServiceModel.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 9.11.2022.
//

import Foundation
import Firebase

class ServiceItemModel: NSObject {
    
    private var ref: DatabaseReference!
    //Product properties
    private var productKey: String!
    private var productPrice: Int!
    private var productQuantity: Int!
    private var email: String!
    private var productImage: String!
    private var productName: String!
    private var productDelivered: Bool!
    
    var key: String {
        return productKey
    }
    var price: Int {
        return productPrice
    }
    var quantity: Int {
        return productQuantity
    }
    var mail: String {
        return email
    }
    var image: String {
        return productImage
    }
    var name: String {
        return productName
    }
    var delivered: Bool {
        return productDelivered
    }
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        
        self.productKey = key
        
        if let productPrice = dictionary["price"] as? Int {
            self.productPrice = productPrice
        }
        if let productQuantity = dictionary["quantity"] as? Int {
            self.productQuantity = productQuantity
        }
        if let email = dictionary["email"] as? String {
            self.email = email
        }
        if let image = dictionary["image"] as? String {
            self.productImage = image
        }
        if let name = dictionary["name"] as? String {
            self.productName = name
        }
        if let delivered = dictionary["delivered"] as? Bool {
            self.productDelivered = delivered
        }
        self.ref = DataService.dataService.item_ref.child(self.productKey)
    }
    
}
