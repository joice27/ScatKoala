//
//  UplaodScattDetailsViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit
import CoreLocation

class UplaodScattDetailsViewController: UIViewController {
    
    @IBOutlet weak var treeSpeciesFeild: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var numberOfScatCollectedField: UITextField!
    @IBOutlet weak var scattPhotoView: UIView!
    @IBOutlet weak var scattConditionLabel: UILabel!
    @IBOutlet weak var scattConditionView: UIView!
    @IBOutlet weak var koalaPresentOrNotLabel: UILabel!
    @IBOutlet weak var poorButton: UIButton!
    @IBOutlet weak var koalaPresentButton: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var excellentButton: UIButton!
    @IBOutlet weak var scattPhotoImageView: UIImageView!
    
    @IBOutlet weak var scattPhotoDescriptionLabel: UILabel!
    var viewModel: KoalaScatUploadViewModel = KoalaScatUploadViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        submitButton.setCornerRadius()
        scattConditionView.isHidden = true
        scattPhotoView.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        showKoalaType()

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        scattPhotoView.isHidden = true
        view.endEditing(true)
    }
    
    func showKoalaType() {
        let isKoalaPresent = UIAction(title: "Yes", handler: {_ in
            self.koalaPresentOrNotLabel.text = "Yes"
        })
        let isKoalaNotPresent = UIAction(title: "No", handler: { _ in
            self.koalaPresentOrNotLabel.text = "No"
        })
        koalaPresentButton.showsMenuAsPrimaryAction = true
        koalaPresentButton.menu = UIMenu(title: "", children: [isKoalaPresent, isKoalaNotPresent])
    }

    
    @IBAction func poorButtonClicked(_ sender: Any) {
        poorButton.setImage(UIImage(named: "buttonSelected"), for: .normal)
        goodButton.setImage(UIImage(), for: .normal)
        excellentButton.setImage(UIImage(), for: .normal)
        self.scattConditionView.isHidden = true
        scattConditionLabel.text = "Poor"
    }
    
    @IBAction func selectScattConditionClicked(_ sender: Any) {
        self.scattConditionView.isHidden = false
    }
    
    @IBAction func goodButtonClicked(_ sender: Any) {
        goodButton.setImage(UIImage(named: "buttonSelected"), for: .normal)
        excellentButton.setImage(UIImage(), for: .normal)
        poorButton.setImage(UIImage(), for: .normal)
        self.scattConditionView.isHidden = true
        scattConditionLabel.text = "Good"

    }
    
    @IBAction func excellentButtonClicked(_ sender: Any) {
        excellentButton.setImage(UIImage(named: "buttonSelected"), for: .normal)
        poorButton.setImage(UIImage(), for: .normal)
        goodButton.setImage(UIImage(), for: .normal)
        self.scattConditionView.isHidden = true
        scattConditionLabel.text = "Excellent"

    }
    
    @IBAction func excellentPhotoViewButtonClicked(_ sender: Any) {
        scattPhotoView.isHidden = false
        scattPhotoImageView.image = UIImage(named: "excellent")
        scattPhotoDescriptionLabel.text = "Scats in excellenet condition appear fresh and have a glossy surface"
    }
    
    @IBAction func goodPhotoViewButtonClicked(_ sender: Any) {
        scattPhotoView.isHidden = false
        scattPhotoImageView.image = UIImage(named: "good")

    }
    
    @IBAction func poorButtonPhotoViewClicked(_ sender: Any) {
        scattPhotoView.isHidden = false
        scattPhotoImageView.image = UIImage(named: "poor")
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to submit?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            self.uploadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: false)
    }
    
    func uploadData() {
        showActivityIndicator()
        viewModel.uploadKoalaDetails(koalaPresent: koalaPresentOrNotLabel.text ?? "", numberOfScatCollected: numberOfScatCollectedField.text ?? "", scatCondition: scattConditionLabel.text ?? "", currentLocation: LocationManager.shared.getCurrentLocation(), lat: LocationManager.shared.latitude, long: LocationManager.shared.longitude, treeSpecies: treeSpeciesFeild.text ?? "", onCompletion: { response, status in
            self.hideActivityIndicator()
            if response?.status == "Success" {
                if let uploadId = response?.dataResponse?.id {
                    self.showSuccessView(uploadId: String(uploadId))
                }
            } else {
                self.showAlert(message: "Error to upload the details")
            }
        })
    }
    
    func showSuccessView(uploadId: String) {
        DispatchQueue.main.async {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scatUploadSuccess") as! ScatUploadSuccessViewController
            vc.uploadId = uploadId
            self.present(vc, animated: false)
        }
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: false)
        }
    }

}

