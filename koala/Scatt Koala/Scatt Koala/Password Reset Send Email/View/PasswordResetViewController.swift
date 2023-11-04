//
//  PasswordResetViewController.swift
//  Scatt Koala
//
//

import UIKit

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailIdView: UIView!
    @IBOutlet weak var emailIdField: UITextField!
    
    let viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailIdView.layer.cornerRadius = 10
        emailIdView.layer.borderWidth = 1
    }
    
    @IBAction func continueButtonClicked(_ sender: Any) {
        if let emailId = emailIdField.text, !emailId.isEmpty {
            showActivityIndicator()
            viewModel.forgotPassword(emailId: emailId, onSuccess: {response in
                self.hideActivityIndicator()
                DispatchQueue.main.async {
                    self.navigateToVerifyOtp(id: response?.dataResponse.id ?? 0)
                }
            }, onFailure: {error in
                self.hideActivityIndicator()
                DispatchQueue.main.async {
                    self.showAlert()
                }
            })
        }
    }
    
    func navigateToVerifyOtp(id: Int) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetVerify") as! PasswordResetVerifyOTPViewController
        viewController.id = Double(id)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "No user was found at this address.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }
}
