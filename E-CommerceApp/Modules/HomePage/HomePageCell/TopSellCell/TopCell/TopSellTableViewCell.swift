//
//  TopSellTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class TopSellTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    private var topSellList: [ProductList] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerHomePageCell()
    }
    private func registerHomePageCell() {
        let cellIdentifier = String(describing: TopSellCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [ProductList]) {
        self.topSellList = model
        collectionView.reloadData()
    }
}
extension TopSellTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topSellList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopSellCollectionViewCell", for: indexPath) as? TopSellCollectionViewCell {
            cell.setTopSell(with: topSellList[indexPath.row])
            cell.configureCell(with: cell)
            return cell
        }
        return UICollectionViewCell()
    }
}
