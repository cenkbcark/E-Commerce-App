//
//  AdminTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 10.11.2022.
//

import UIKit
import SDWebImage

final class AdminTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var orderDelivered: UIImageView!
    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var userNameLbl: UILabel!
    @IBOutlet weak private var productQuantity: UILabel!
    @IBOutlet weak private var productPrice: UILabel!
    @IBOutlet weak private var productTitle: UILabel!
    
    func setData(with data: ServiceItemModel) {
        productImage.sd_setImage(with: URL(string: data.image))
        userNameLbl.text = "Ordered by: \(data.mail)"
        productPrice.text = "Price: \(data.price) $"
        productTitle.text = data.name
        productQuantity.text = "Total: \(data.quantity)"
        if data.delivered == true {
            orderDelivered.image = UIImage(named: "order-true")
        }else {
            orderDelivered.image = UIImage(named: "order-false")
        }
    }
    
}
