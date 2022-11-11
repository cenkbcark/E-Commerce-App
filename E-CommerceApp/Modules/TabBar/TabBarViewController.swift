//
//  TabBarViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit
import Firebase

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logOutButton = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .done, target: self, action: #selector(didTappedLogOutButton))
        logOutButton.tintColor = .white
        self.navigationItem.rightBarButtonItems = [logOutButton]
        let networkManager = NetworkManager(session: .shared)
        let productApi = ProductAPI(networkManager: networkManager)
        let productViewModel = ProductViewModel(productApi: productApi)
        let homePageVC = HomePageViewController(viewModel: productViewModel)
        let homePageNavVC = homePageVC
        homePageNavVC.title = "Home Page"
        //
        let categoryVC = CategoriesViewController()
        let categoryNavVC = categoryVC
        categoryNavVC.title = "Categories"
        //
        let cardVC = CardViewController()
        cardVC.title = "Card"
        let profileVC = ProfileViewController()
        profileVC.title = "Profile"
        //
        self.setViewControllers([homePageNavVC,categoryNavVC,cardVC,profileVC], animated: true)
        guard let items = self.tabBar.items else { return }
        let images = ["house.fill","rectangle.grid.3x2","creditcard.fill","person.fill"]
        for x in 0...3 {
            items[x].image = UIImage(systemName: images[x])
        }
        self.tabBar.tintColor = .white
        self.tabBar.barTintColor = .systemOrange
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    @objc func didTappedLogOutButton() {
        do{
            try Auth.auth().signOut()
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }catch {
            showAlert(alertTitle: "Error", messageInput: "Error while exiting process", VC: self)
        }
    }
}
