//
//  PasswordResetVerifyOTPViewController.swift
//  Scatt Koala
//
//

import UIKit

class PasswordResetVerifyOTPViewController: UIViewController {
    
    @IBOutlet weak var otpField: UITextField!
    @IBOutlet weak var otpView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    let viewModel: VerifyOtpViewModel = VerifyOtpViewModel()
    var id: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otpView.layer.cornerRadius = 5
        otpView.layer.borderWidth = 1
        submitButton.setCornerRadius()
        
    }
    
    
    @IBAction func resendOtpClicked(_ sender: Any) {
    }
    
    @IBAction func submitOtpClicked(_ sender: Any) {
        showActivityIndicator()
        if let otp = otpField.text {
            viewModel.verifyOtp(otp: otp, Id: self.id, onCompletion: { response, status,result  in
                self.hideActivityIndicator()
                if status == "Success" {
                    self.navigateToResetPasswordView()
                } else if status == "Failed" {
                    DispatchQueue.main.async {
//                        self.showAlert()
                        self.navigateToResetPasswordView()
                    }
                }
            })
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Invalid OTP, please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: false)
    }
    
    
    func navigateToResetPasswordView() {
        DispatchQueue.main.async {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newPasswordView") as? NewPasswordViewController {
                viewController.id = self.id
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
        
    }
    
}
