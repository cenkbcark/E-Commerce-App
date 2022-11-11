//
//  CardTableViewCell.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 8.11.2022.
//

import UIKit

protocol CardTableViewCellProtocol {
    func setPrice(product: ProductList)
}

final class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCount: UILabel!
    
    private var product: ProductList?
    private var currentValue: Double = 1.0
    
    var mainVC: UIViewController!
    var delegate: CardTableViewCellProtocol?
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
    }
    func setCardItem(with data: ProductList) {
        product = data
        productImage.sd_setImage(with: URL(string: data.thumbnail))
        productPrice.text = "\(data.price * data.quantity ) $"
        productTitle.text = data.title
    }
    
    @IBAction func countStepplerClicked(_ sender: UIStepper) {
        productCount.text = "Total: \(Int(sender.value))"
        guard var product = product else { return }
        if currentValue < sender.value {
            product.quantity += 1
        } else {
            product.quantity -= 1
        }
        currentValue = sender.value
        product.quantity = Int(currentValue)
        delegate?.setPrice(product: product)
        
        if Int(sender.value) == 10 {
            let alert = UIAlertController(title: "Warning", message: "You can not add more item", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okButton)
            mainVC.present(alert, animated: true)
            //UIApplication.topViewController()?.present(alert, animated: true)
        }
    }
}

