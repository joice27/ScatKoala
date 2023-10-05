//
//  SignInViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let viewModel: SignInViewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func signInButtonClick(_ sender: Any) {
        if let email = userNameField.text, let password = passwordField.text {
            showActivityIndicator()
            viewModel.signIn(email: email, password: password, omCompletion: {response, status in
                self.hideActivityIndicator()
                if status {
                    self.navigateToHomePage()
                } else {
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: response)
                    }
                }
            })
        }
    }
    
    func navigateToHomePage() {
        DispatchQueue.main.async {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVc") as? HomeViewController {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }
    
    func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: false)
    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpView") as? SignUpViewController {
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}
