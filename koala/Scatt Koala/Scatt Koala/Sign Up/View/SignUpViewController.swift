//
//  SignUpViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    var viewModel: SignUpViewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)

    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if let emailId = emailAddressField.text, let firstName = firstNameField.text, let lastName = lastNameField.text, let password = passwordField.text, let confirmPassword = confirmPasswordField.text, !firstName.isEmpty, !lastName.isEmpty, !firstName.isEmpty, !password.isEmpty, !confirmPassword.isEmpty {
            if password != confirmPassword {
                showAlert(message: "The passwords you entered do not match. Please try again.", title: "Error")
            } else if password.count < 8 {
                showAlert(message: "Please enter a stronger password", title: "Error")
            } else {
                showActivityIndicator()
                viewModel.SignUp(email: emailId, password: password, firstName: firstName, lastName: lastName, omCompletion: {response, status in
                    self.hideActivityIndicator()
                    if status {
                        self.showAlert(message: response, title: "Success")
                    } else {
                        self.showAlert(message: response, title: nil)
                    }
                })
            }
        } else {
            showAlert(message: "Oops! You forgot to fill in some required information.", title: "Error")
        }

    }
    
    func showAlert(message: String?, title: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alert, animated: false)
        }
        
    }
    
    @IBAction func gpobackButtonClicked(_ sender: Any) {
    }
}
