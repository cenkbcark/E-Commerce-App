//
//  CardViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit
import Firebase
import ProgressHUD

final class CardViewController: UIViewController {
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCostLabel: UILabel!
    var cardItems: [ProductList] = []
    private var totalCost = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        calculateTotal()
        registerCardCell()
        cardItems = Carts.shared.cardList
        orderButton.layer.cornerRadius = 15
        
    }
    @IBAction func completeOrderClicked(_ sender: Any) {
        if cardItems.count == 0 {
            //showAlert(alertTitle: "Ahh!", messageInput: "Please add item into your cart", VC: self)
            ProgressHUD.showFailed("Please add item into your cart ")
        }
        for order in cardItems {
            let price = order.price
            let currentUser = Auth.auth().currentUser
            let quantity = order.quantity
            let image = order.thumbnail
            let name = order.title
            let newItem: Dictionary<String, Any> = ["quantity": quantity, "price" : price, "email": currentUser?.email ?? "", "image" : image, "name" : name, "delivered" : false]
            orderProduct(item: newItem)
        }
    }
    func orderProduct(item: Dictionary<String,Any>) {
        let firebaseNewItem = DataService.dataService.item_ref.childByAutoId()
        
        firebaseNewItem.setValue(item) { error, ref in
            
            if error != nil {
                //showAlert(alertTitle: "ERROR", messageInput: "Something went wrong", VC: self)
                ProgressHUD.showFailed("Something went wrong")
            }else {
                //showAlert(alertTitle: "Done", messageInput: "Your order has been received, Please check your email.", VC: self)
                ProgressHUD.showSuccess("Your order has been received.Please check your email")
                Carts.shared.cardList.removeAll()
                self.cardItems.removeAll()
                self.tableView.reloadData()
                self.totalCost = 0
                self.totalCostLabel.text = "Total cost: \(self.totalCost) $"
            }
        }
    }
    private func registerCardCell() {
        let cellIdentifier = String(describing: CardTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    func calculateTotal() {
        totalCost = 0
        for item in cardItems {
            let productPrice = item.quantity * item.price
            totalCost += productPrice
        }
        totalCostLabel.text = "Total cost: \(totalCost) $"
    }
    override func viewWillAppear(_ animated: Bool) {
        cardItems = Carts.shared.cardList
        calculateTotal()
        tableView.reloadData()
    }
}
extension CardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as? CardTableViewCell {
            cell.setCardItem(with: cardItems[indexPath.row])
            cell.delegate = self
            cell.mainVC = self
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
}

extension CardViewController: CardTableViewCellProtocol {
    func setPrice(product: ProductList) {
        if let index = cardItems.firstIndex(where: { $0.id == product.id }) {
            cardItems[index].quantity = product.quantity
            calculateTotal()
            tableView.reloadData()
        }
    }
}
