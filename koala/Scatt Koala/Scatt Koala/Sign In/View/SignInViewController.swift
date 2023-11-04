//
//  SignInViewController.swift
//  Scatt Koala
//
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var passwordFieldView: UIView!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var iconClick = true
    let viewModel: SignInViewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordFieldView.layer.cornerRadius = 5
        signInButton.setCornerRadius()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.navigationItem.hidesBackButton = true
        view.addGestureRecognizer(tapGesture)
        showHideButton.setImage(UIImage(named: "hidePassword"), for: .normal)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func passwordShoeAndHideClicked(_ sender: Any) {
        if iconClick {
            passwordField.isSecureTextEntry = false
            showHideButton.setImage(UIImage(named: "showPassword"), for: .normal)
        } else {
            passwordField.isSecureTextEntry = true
            showHideButton.setImage(UIImage(named: "hidePassword"), for: .normal)
        }
        iconClick = !iconClick

    }
    
    @IBAction func signInButtonClick(_ sender: Any) {
        if let email = userNameField.text, let password = passwordField.text {
            showActivityIndicator()
            viewModel.signIn(email: email, password: password, omCompletion: {response, status in
                self.hideActivityIndicator()
                if response?.status == "Success" {
                    self.navigateToHomePage()
                } else {
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: response?.msg)
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
    
    @IBAction func forgotPasswordClicked(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "forgotPasswordView") as? PasswordResetViewController {
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
    
    @IBAction func signUpButtonClick(_ sender: Any) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signUpView") as? SignUpViewController {
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}
