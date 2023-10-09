//
//  VerifyOTPViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 09/10/23.
//

import UIKit

class VerifyOTPViewController: UIViewController {

    @IBOutlet weak var verifyOtpView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var otpField: UITextField!
    
    let viewModel: VerifyOtpViewModel = VerifyOtpViewModel()
    var id: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verifyOtpView.layer.borderWidth = 1
        verifyOtpView.layer.cornerRadius = 10
        submitButton.setCornerRadius()
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        showActivityIndicator()
        if let otp = otpField.text {
            viewModel.verifyOtp(otp: otp, Id: self.id, onCompletion: { response, status,result  in
                self.hideActivityIndicator()
                if status == "Success" {
                    self.navigateToHomePage()
                } else if status == "Failed" {
                    self.showAlert(message: response)
                }
            })

        }
    }
    
    func showAlert(message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    func navigateToHomePage() {
        DispatchQueue.main.async {
            if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVc") as? HomeViewController {
                self.navigationController?.pushViewController(viewController, animated: false)
            }
        }
    }

}
