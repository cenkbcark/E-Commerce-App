//
//  HomePageViewModel.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import Foundation

protocol ProductViewModelInput {
    var output: ProductViewModelOutput? {get set}
    
    func viewDidLoad()
    func retrieveProducts()
}

protocol ProductViewModelOutput: AnyObject {
    func home(_home viewModel: ProductViewModelInput, productList: [ProductList])
}

final class ProductViewModel: ProductViewModelInput {
    var productList: [ProductList] = []
    private let productApi: ProductFetchable
    var output: ProductViewModelOutput?
    
    init(productApi: ProductAPI) {
        self.productApi = productApi
    }
    
    func viewDidLoad() {
        retrieveProducts()
    }
    
    func retrieveProducts() {
        LoadingManager.shared.show()
        productApi.retrieveItems(request: .init()) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let productList):
                self.productList.append(contentsOf: productList.products)
                self.output?.home(_home: self, productList: productList.products)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
}
