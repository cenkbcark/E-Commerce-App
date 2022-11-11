//
//  AdvantageTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class AdvantageTableViewCell: UITableViewCell {
    private var productList: [ProductList] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerHomePageCell()
    }
    private func registerHomePageCell() {
        let cellIdentifier = String(describing: AdvantageCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [ProductList]) {
        self.productList = model
        collectionView.reloadData()
    }
    
}
extension AdvantageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdvantageCollectionViewCell", for: indexPath) as? AdvantageCollectionViewCell {
            cell.setAdvantage(with: productList[indexPath.row])
            cell.configureCell(with: cell)
            return cell
        }
        return UICollectionViewCell()
    }
}
