
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    
 
    @Published var location: CLLocationCoordinate2D?
     

    override init() {
        super.init()
         manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error determining location:", error)
    }
    
    func getLocationCity(lat: Double, long: Double, completion: @escaping (String) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: long)
        geoCoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, let city = placemark.subAdministrativeArea else {
                if let error = error {
                    print("Error retrieving city name:", error)
                }
                completion("")
                return
            }
            completion(city)
        }
    }
 
    
    
}
