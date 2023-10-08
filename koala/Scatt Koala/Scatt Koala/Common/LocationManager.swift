import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager() // Singleton instance
    
    private let locationManager = CLLocationManager()
    private var currentLocation: String = ""
    var latitude: String = ""
    var longitude: String = ""
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> String {
        return currentLocation
    }
    
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
                        self.currentLocation = city
                        self.locationManager.stopUpdatingLocation()
                        NotificationCenter.default.post(name: Notification.Name("LocationUpdated"), object: nil)
                    } else if let area = placemark.subLocality {
                        print("Current area: \(area)")
                    }
                }
            }
        }
    }
}
