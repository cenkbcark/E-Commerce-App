//
//  DetailTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var productTitleLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productBrandLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var productDescription: UILabel!
    var addToCartProtocol : AddToCartProtocol?
    var indexPath: IndexPath?
    private var imagesURL: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        addToCart.layer.cornerRadius = 10
        registerImagesCell()
    }
    private func registerImagesCell() {
        let cellIdentifier = String(describing: ImagesCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func setData(with data: ProductList) {
        productBrandLbl.text = data.brand
        productPriceLbl.text = "\(data.price) $"
        productTitleLbl.text = data.title
        productDescription.text = data.productDescription
        imagesURL = data.images
        
    }
    @IBAction func addToCartClicked(_ sender: Any) {
        addToCartProtocol?.addList(indexpath: indexPath!)
    }
    
    
}
extension DetailTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesURL.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as? ImagesCollectionViewCell {
            cell.setImage(with: imagesURL[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
protocol AddToCartProtocol {
    func addList(indexpath: IndexPath)
}
