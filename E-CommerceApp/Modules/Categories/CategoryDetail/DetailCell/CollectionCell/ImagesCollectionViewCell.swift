//
//  ImagesCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit
import SDWebImage

final class ImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    func setImage(with data: String) {
        productImage.sd_setImage(with: URL(string: data))
    }

}
