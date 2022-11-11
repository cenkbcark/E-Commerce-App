//
//  AdminViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 10.11.2022.
//

import UIKit
import Firebase
import ProgressHUD

final class AdminViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var items: [ServiceItemModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        tableView.delegate = self
        tableView.dataSource = self
        setUpBarButton()
        registerAdminCell()
        getAllOrders()
        
        
    }
    private func setUpBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: UIBarButtonItem.Style.done, target: self, action: #selector(adminLogout))
        navigationController?.navigationBar.tintColor = .orange
    }
    @objc func adminLogout() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }catch {
            //showAlert(alertTitle: "Error", messageInput: "Error while exiting process", VC: self)
            ProgressHUD.showFailed("Error while exiting process")
        }
    }
    private func setTitle() {
        self.title = "Admin Panel"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    private func registerAdminCell() {
        let cellIdentifier = String(describing: AdminTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func getAllOrders() {
        
        DataService.dataService.item_ref.observe(.value, with: {(snapshot: DataSnapshot?) in
            if let snapshot = snapshot?.children.allObjects as? [DataSnapshot] {
                self.items.removeAll()
                
                for snap in snapshot {
                    if let postDic = snap.value as? Dictionary <String, AnyObject> {
                        let items = ServiceItemModel(key: snap.key, dictionary: postDic)
                        self.items.insert(items, at: 0)
                    }
                }
                self.tableView.reloadData()
            }
        })
    }
    private func orderCompleted(with item: ServiceItemModel) {
        let orderCompleted : Dictionary<String, Any> = ["delivered" : true]
        
        DataService.dataService.item_ref.child(item.key).updateChildValues(orderCompleted) { error , ref in
            if error != nil {
                //showAlert(alertTitle: "Error", messageInput: "Order delivery has been failed.", VC: self)
                ProgressHUD.showFailed("Order delivery has been failed")
            }else {
                //showAlert(alertTitle: "Done", messageInput: "Order delivered.", VC: self)
                ProgressHUD.showSuccess("Order delivey has been confirmed.")
            }
        }
    }
}
extension AdminViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AdminTableViewCell", for: indexPath) as? AdminTableViewCell {
            cell.setData(with: items[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let orderCompletion = UIContextualAction(style: UIContextualAction.Style.normal, title: "Delivered") { action, view, completionHandler in
            
            self.orderCompleted(with: self.items[indexPath.row])
            completionHandler(true)
        }
        orderCompletion.backgroundColor = .orange
        let swipeRight = UISwipeActionsConfiguration(actions: [orderCompletion])
        return swipeRight
    }
}
