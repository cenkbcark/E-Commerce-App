//
//  CardViewModel.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import Foundation

class Carts {
    
    static let shared = Carts()
    
    var cardList: [ProductList] = []
    
    private init() { }
}
