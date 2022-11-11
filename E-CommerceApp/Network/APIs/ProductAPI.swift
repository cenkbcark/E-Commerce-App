//
//  ProductAPI.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import Foundation

protocol ProductFetchable {
    func retrieveItems(request: ProductRequestModel, completion: @escaping (Result<ProductModel, ApiError>) -> Void)
}

final class ProductAPI: ProductFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveItems(request: ProductRequestModel, completion: @escaping (Result<ProductModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
