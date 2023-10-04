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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        showKoalaType()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

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
        let alert = UIAlertController(title: "Success", message: "Successfully Uploaded data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: false)
        
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

                geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                    if let error = error {
                        print("Reverse geocoding error: \(error.localizedDescription)")
                        return
                    }

                    if let placemark = placemarks?.first {
                        if let city = placemark.locality {
                            print("Current city: \(city)")
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
