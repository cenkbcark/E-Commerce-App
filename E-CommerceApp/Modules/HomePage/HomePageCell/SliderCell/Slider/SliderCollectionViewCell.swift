//
//  SliderCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

final class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var sliderImageView: UIImageView!
    func setSlider(with data: SliderModel) {
        sliderImageView.image = data.image
    }

}
