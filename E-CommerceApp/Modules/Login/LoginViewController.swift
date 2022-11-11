//
//  LoginViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit
import Firebase
import Lottie
import ProgressHUD

final class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        logInButton.layer.cornerRadius = 10
        setupAnimation()
    }
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("shopping")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAnimation()
    }

    @IBAction func logInButtonClicked(_ sender: Any) {
        if emailTextField.text == "garion@admin.com" && passwordTextField.text == "admin123" {
            self.navigationController?.pushViewController(AdminViewController(), animated: true)
        }else {
            if emailTextField.text != nil && passwordTextField.text != nil {
                guard let email = emailTextField.text else { return }
                guard let password = passwordTextField.text else { return }
                Auth.auth().signIn(withEmail: email, password: password){ data, error in
                    if error != nil {
                        //showAlert(alertTitle: "Error", messageInput: "Please check your email and password!", VC: self)
                        ProgressHUD.showFailed("Please check your email and password!")
                    }else {
                        let tabBarVC = TabBarViewController()
                        tabBarVC.view.backgroundColor = .systemOrange
                        self.navigationController?.pushViewController(tabBarVC, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
