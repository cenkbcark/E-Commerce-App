//
//  DetailViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class DetailViewController: UIViewController {

    private var selectedCategory: String?
    private var categoryList: [ProductList] = []
    private var viewModel: ProductViewModelInput
    init(selectedCategory: String, viewModel: ProductViewModelInput) {
        self.selectedCategory = selectedCategory
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: .main)
        self.viewModel.output = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerDetailCell()
        viewModel.viewDidLoad()
    }
    private func registerDetailCell() {
        let cellIdentifier = String(describing: DetailTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
}
extension DetailViewController: ProductViewModelOutput {
    func home(_home viewModel: ProductViewModelInput, productList: [ProductList]) {
        categoryList = productList.filter({ return $0.category == selectedCategory!})
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell {
            cell.setData(with: categoryList[indexPath.row])
            cell.addToCartProtocol = self
            cell.indexPath = indexPath
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
extension DetailViewController: AddToCartProtocol {
    func addList(indexpath: IndexPath) {
        let selectedProduct = categoryList[indexpath.row]
        if Carts.shared.cardList.contains(where: {$0.title == selectedProduct.title}) {
            showAlert(alertTitle: "Warning", messageInput: "This item is already in your carts.", VC: self)
        }else {
            Carts.shared.cardList.append(selectedProduct)
        }
    }
}
