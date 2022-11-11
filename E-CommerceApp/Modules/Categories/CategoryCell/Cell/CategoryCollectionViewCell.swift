//
//  CategoryCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCategory(with data: CategoryModel){
        categoryTitle.text = data.title.uppercased()
        categoryImage.image = data.image
    }
    func configureCell(with cell: CategoryCollectionViewCell) {
        cell.layer.cornerRadius = 25
    }
}
