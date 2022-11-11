//
//  CategoriesViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit

final class CategoriesViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var categoryList: [CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerCategoryCell()
        setCategoryData()
    }
    func setCategoryData() {
        categoryList.append(CategoryModel(title: "laptops", image: UIImage(named: "laptops")!))
        categoryList.append(CategoryModel(title: "smartphones", image: UIImage(named: "smartphones")!))
        categoryList.append(CategoryModel(title: "skincare", image: UIImage(named: "skincare")!))
        categoryList.append(CategoryModel(title: "groceries", image: UIImage(named: "groceries")!))
        categoryList.append(CategoryModel(title: "fragrances", image: UIImage(named: "fragrances")!))
        categoryList.append(CategoryModel(title: "home-decoration", image: UIImage(named: "home-decoration")!))
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    private func registerCategoryCell() {
        let cellIdentifier = String(describing: CategoryCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
extension CategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            cell.setCategory(with: categoryList[indexPath.row])
            cell.configureCell(with: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let productApi = ProductAPI(networkManager: networkManager)
        let detailViewModel = ProductViewModel(productApi: productApi)
        let detailVC = DetailViewController(selectedCategory: categoryList[indexPath.row].title, viewModel: detailViewModel)
        print(categoryList[indexPath.row].title)
        UIApplication.topViewController()?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
