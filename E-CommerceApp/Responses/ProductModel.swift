//
//  ProductModel.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import Foundation
// MARK: - ProductModel
struct ProductModel: Codable {
    let products: [ProductList]
    let total, skip, limit: Int
}

// MARK: - Product
struct ProductList: Codable {
    let id: Int
    let title, productDescription: String
    var price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
    var quantity: Int = 1

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}

