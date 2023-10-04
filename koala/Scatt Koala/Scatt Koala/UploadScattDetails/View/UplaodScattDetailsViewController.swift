//
//  UplaodScattDetailsViewController.swift
//  Scatt Koala
//
//  Created by Joice George on 05/10/23.
//

import UIKit
import CoreLocation

class UplaodScattDetailsViewController: UIViewController {
    
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
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
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
        scattPhotoImageView.image = UIImage(named: "good 2")
    }
    
    @IBAction func goodPhotoViewButtonClicked(_ sender: Any) {
        scattPhotoView.isHidden = false
        scattPhotoImageView.image = UIImage(named: "good 3")

    }
    
    @IBAction func poorButtonPhotoViewClicked(_ sender: Any) {
        scattPhotoView.isHidden = false
        scattPhotoImageView.image = UIImage(named: "excellent 1")

    }
}

extension UplaodScattDetailsViewController: CLLocationManagerDelegate{
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
                            self.currentLocationLabel.text = city
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

