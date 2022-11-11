//
//  AdvantageCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit
import SDWebImage

final class AdvantageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak private var discountView: UIView!
    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var productLbl: UILabel!
    @IBOutlet weak private var discountLbl: UILabel!
    @IBOutlet weak private var priceLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setAdvantage(with data: ProductList) {
        productLbl.text = data.title
        discountLbl.text = "%\(data.discountPercentage)"
        priceLbl.text = "\(data.price) $"
        brandLabel.text = data.brand
        productImage.sd_setImage(with: URL(string: data.thumbnail))
        discountView.layer.cornerRadius = discountView.frame.height / 2
        productImage.layer.cornerRadius = 15
    }
    func configureCell(with cell: AdvantageCollectionViewCell) {
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = UIColor.lightGray.cgColor
    }
}
