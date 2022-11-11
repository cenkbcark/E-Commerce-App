//
//  RegisterViewController.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import UIKit
import Firebase
import Lottie
import ProgressHUD

final class RegisterViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 10
        setupAnimation()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupAnimation()
    }
    private func setupAnimation() {
        animationView.animation = LottieAnimation.named("login-ready")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
    }
    @IBAction func registerBtnClicked(_ sender: Any) {
        if emailTextField.text != nil {
            if passwordTextField.text == passwordAgainTextField.text {
                guard let email = emailTextField.text else { return }
                guard let password = passwordTextField.text else { return }
                Auth.auth().createUser(withEmail: email, password: password) { data, error in
                    
                    if error != nil {
                        //showAlert(alertTitle: "Error", messageInput: "Please try again later!", VC: self)
                        ProgressHUD.showFailed("Please try again later!")
                    }else {
                        showAlertBackHome(alertTitle: "Congrats", messageInput: "You have succesfully create an account!", VC: self, backVC: LoginViewController())
                    }
                }
            }else {
                //showAlert(alertTitle: "Error", messageInput: "Password does not match!", VC: self)
                ProgressHUD.showFailed("Password does not match!")
            }
        }
    }
}
