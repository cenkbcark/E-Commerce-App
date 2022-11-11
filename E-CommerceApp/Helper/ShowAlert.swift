//
//  ShowAlert.swift
//  E-CommerceApp
//
//  Created by Cenk Bahadır Çark on 7.11.2022.
//

import Foundation
import UIKit

func showAlert(alertTitle: String, messageInput: String, VC: UIViewController) {
    let alert = UIAlertController(title: alertTitle, message: messageInput, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(okButton)
    VC.present(alert, animated: true)
}
func showAlertBackHome(alertTitle: String, messageInput: String, VC: UIViewController, backVC: UIViewController) {
    let alert = UIAlertController(title: alertTitle, message: messageInput, preferredStyle: .alert)
    let okButton = UIAlertAction(title: "OK", style: .default, handler: {_ in
        VC.navigationController?.popViewController(animated: true)
    })
    alert.addAction(okButton)
    VC.dismiss(animated: true)
    VC.present(alert, animated: true)
}
