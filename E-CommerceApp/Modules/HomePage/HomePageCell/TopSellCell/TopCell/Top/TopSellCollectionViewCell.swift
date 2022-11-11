//
//  TopSellCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit
import SDWebImage
final class TopSellCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var brandLabel: UILabel!
    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var discountLbl: UILabel!
    @IBOutlet weak private var priceLbl: UILabel!
    @IBOutlet weak private var productLbl: UILabel!
    @IBOutlet weak private var discountView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setTopSell(with data: ProductList) {
        discountLbl.text = "\(data.discountPercentage)"
        priceLbl.text = "\(data.price) $"
        productLbl.text = data.title
        brandLabel.text = data.brand
        productImage.sd_setImage(with: URL(string: data.thumbnail))
        discountView.layer.cornerRadius = discountView.frame.height / 2
        productImage.layer.cornerRadius = 15
        
    }
    func configureCell(with cell: TopSellCollectionViewCell) {
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
    }

}
