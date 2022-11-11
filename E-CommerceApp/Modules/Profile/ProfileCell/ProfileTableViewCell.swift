//
//  ProfileTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 10.11.2022.
//

import UIKit
import SDWebImage
import Firebase

final class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak private var productDelivered: UIImageView!
    @IBOutlet weak private var productImage: UIImageView!
    @IBOutlet weak private var productQuantity: UILabel!
    @IBOutlet weak private var productName: UILabel!
    @IBOutlet weak private var productPrice: UILabel!
    
    func setData(with data: ServiceItemModel) {
        if Auth.auth().currentUser?.email == data.mail {
            productName.text = data.name
            productQuantity.text = "Total: \(data.quantity)"
            productPrice.text = "\(data.price) $"
            productImage.sd_setImage(with: URL(string: data.image))
            DispatchQueue.main.async {
                if data.delivered == true {
                    self.productDelivered.image = UIImage(named: "order-true")
                }else {
                    self.productDelivered.image = UIImage(named: "order-false")
                }
            }
        }
    }
}
