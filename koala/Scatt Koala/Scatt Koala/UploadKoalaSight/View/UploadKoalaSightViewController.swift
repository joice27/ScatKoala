//
//  UploadKoalaSightViewController.swift
//  Scatt Koala
//
//

import UIKit
import CoreLocation

class UploadKoalaSightViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var treeSpeciesLabel: UILabel!
    @IBOutlet weak var treeSpeciesField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var koalaStatusLabel: UILabel!
    @IBOutlet weak var koalaTypeButton: UIButton!
    @IBOutlet weak var koalaImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    var viewModel: KoalaUplaodViewModel = KoalaUplaodViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.setCornerRadius()
        takePhotoButton.setCornerRadius()
        imagePicker.delegate = self
        showKoalaType()
        koalaImageView.image = UIImage(systemName: "photo.circle")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationLabel.text = LocationManager.shared.getCurrentLocation() 
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func showKoalaType() {
        let aliveKoala = UIAction(title: "Alive", handler: {_ in
            self.koalaStatusLabel.text = "Alive"
        })
        let unwellKoala = UIAction(title: "Unwell/Rescue", handler: { _ in
            self.koalaStatusLabel.text = "Unwell/ Rescue"
        })
        let deadKoala = UIAction(title: "Dead", handler: { _ in
            self.koalaStatusLabel.text = "Dead"
        })
        koalaTypeButton.showsMenuAsPrimaryAction = true
        koalaTypeButton.menu = UIMenu(title: "", children: [aliveKoala, unwellKoala, deadKoala])
    }
    
    @IBAction func submitButtonPress(_ sender: Any) {
        
        if koalaImageView.image == UIImage(systemName: "photo.circle") || koalaStatusLabel.text == "Select" || treeSpeciesField.text == "" {
            self.showAlert(message: "All fields are required")
        } else {
            let alert = UIAlertController(title: nil, message: "Are you sure you want to submit?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.uploadImage()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func uploadData(imageUrl: String) {
        if let koalaStatus = koalaStatusLabel.text, let treeSpecies = treeSpeciesField.text {
            viewModel.uploadKoalaDetails(koalaStatus: koalaStatus, currentLocation: LocationManager.shared.getCurrentLocation(), lat: LocationManager.shared.latitude, long: LocationManager.shared.longitude, treeSpecies: treeSpecies, imageUrl: imageUrl, onCompletion: {response, status in
                self.hideActivityIndicator()
                if response?.status == "Success" {
                    self.showAlert(message: "Successfully uploaded the Image")
                } else {
                    self.showAlert(message: "Error to uplod file, please try again")
                }
            })
        }
    }
    
    func uploadImage() {
        if let image = koalaImageView.image {
            showActivityIndicator()
            NetworkManager.uploadImage(image: image, onCompletion: { response in
                if  let url = response?.dataResponse {
                    DispatchQueue.main.async{
                        self.uploadData(imageUrl: url)
                    }
                } else {
                    self.showAlert(message: "Error to uplod file, please try again")
                }
            })
        }
    }
    
    @IBAction func takePhotoClicked(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { (_) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Choose from Library", style: .default) { (_) in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        if let button = sender as? UIButton {
            if UIDevice.current.userInterfaceIdiom == .pad {
                alertController.popoverPresentationController?.sourceView = button
                alertController.popoverPresentationController?.sourceRect = button.bounds
            }
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.koalaImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

