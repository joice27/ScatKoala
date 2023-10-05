//
//  UploadKoalaSightViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit
import CoreLocation

class UploadKoalaSightViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var treeSpeciesLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var koalaStatusLabel: UILabel!
    @IBOutlet weak var koalaTypeButton: UIButton!
    @IBOutlet weak var koalaImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    let locationManager = CLLocationManager()
    var currentLocation: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var viewModel: KoalaUplaodViewModel = KoalaUplaodViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        showKoalaType()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
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
        if let koalaStatus = koalaStatusLabel.text, let treeSpecie = treeSpeciesLabel.text {
            showActivityIndicator()
            viewModel.uploadKoalaDetails(koalaStatus: koalaStatus, currentLocation: currentLocation, lat: latitude, long: longitude, treeSpecies: treeSpecie, onCompletion: {response, status in
                self.hideActivityIndicator()
                if status {
                    self.showAlert(message: "Successfully uploaded the Image")
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

extension UploadKoalaSightViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                let geocoder = CLGeocoder()
                self.latitude = String(location.coordinate.latitude)
                self.longitude = String(location.coordinate.longitude)

                geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        print("Reverse geocoding error: \(error.localizedDescription)")
                        return
                    }

                    if let placemark = placemarks?.first {
                        if let city = placemark.locality {
                            print("Current city: \(city)")
                            self.currentLocation = city
                            self.locationManager.stopUpdatingLocation()
                            self.locationLabel.text = city
                        } else if let area = placemark.subLocality {
                            print("Current area: \(area)")
                        } else {
                            print("Location information unavailable")
                        }
                    }
                }
            }
        }
    }
