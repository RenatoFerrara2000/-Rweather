
import CoreLocation
import CoreLocationUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
   
    let manager = CLLocationManager()
    
<<<<<<< Updated upstream
    
 
    @Published var location: CLLocationCoordinate2D?
     
=======
    //location initialized to rome in case user doesn't share location
    @Published var location = CLLocationCoordinate2D(latitude:41.902, longitude: 12.496)

>>>>>>> Stashed changes

    override init() {
        super.init()
         manager.delegate = self
    }

    func requestLocation() {
          manager.requestLocation()
    }

<<<<<<< Updated upstream
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
=======
    //update current to location to the last location found
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
         location = locations.last!.coordinate 
>>>>>>> Stashed changes
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error determining location:", error)
    }
    
    //using the location coordinates, find 
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
