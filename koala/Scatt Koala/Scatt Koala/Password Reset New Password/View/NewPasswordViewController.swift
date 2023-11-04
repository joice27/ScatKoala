//
//  NewPasswordViewController.swift
//  Scatt Koala
//
//

import UIKit

class NewPasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var id: Double?
    let viewModel: NewPasswordViewModel = NewPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.setCornerRadius()
    }
    
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        if let password = passwordField.text, let confirmPassword = confirmPasswordField.text {
            if password != confirmPassword {
                showAlert(message: "The passwords you entered do not match. Please try again.")
            } else if password.count < 8 {
                showAlert(message: "Please enter a stronger password")
            } else {
                self.showActivityIndicator()
                viewModel.resetPassword(id: self.id ?? Double(0), newPassword: password, onSuccess: { response in
                    self.hideActivityIndicator()
                    self.showAlert(message: "\(response?.msg ?? ""). Please login again to continue", status: true)
                    
                }, onFailure: { error in
                    self.hideActivityIndicator()
                    self.showAlert(message: error, title: "Error")
                })
            }
        }
    }
        
    func showAlert(message: String?, title: String? = nil, status: Bool? = nil) {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                    if let status  {
                        if let viewController = self.navigationController?.viewControllers.first(where: { $0 is SignInViewController}) {
                            self.navigationController?.popToViewController(viewController, animated: status)
                        }
                    }
                }))
                self.present(alert, animated: false)
            }
        }
    }
