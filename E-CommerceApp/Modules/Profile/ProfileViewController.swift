//
//  ProfileViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 9.11.2022.
//

import UIKit
import Firebase

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    private var items: [ServiceItemModel] = []
    private var ownItems: [ServiceItemModel] = []
    let currentUser = Auth.auth().currentUser?.email
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        registerProfileCell()
        getAllOrders()
    }
    
    private func registerProfileCell() {
        let cellIdentifier = String(describing: ProfileTableViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        tableview.register(nib, forCellReuseIdentifier: cellIdentifier)
    }
    private func getAllOrders() {
        DataService.dataService.item_ref.observe(.value, with: {(snapshot: DataSnapshot?) in
            if let snapshot = snapshot?.children.allObjects as? [DataSnapshot] {
                self.items.removeAll()
                self.ownItems.removeAll()
                for snap in snapshot {
                    if let postDic = snap.value as? Dictionary <String, AnyObject> {
                        let items = ServiceItemModel(key: snap.key, dictionary: postDic)
                        self.items.insert(items, at: 0)
                    }
                }
                //self.tableview.reloadData()
                for product in self.items {
                    if self.currentUser == product.mail {
                        self.ownItems.append(product)
                    }
                }
                self.tableview.reloadData()
            }
        })
    }
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ownItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as? ProfileTableViewCell {
            cell.setData(with: ownItems[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 156
    }
}
