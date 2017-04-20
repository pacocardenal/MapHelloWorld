import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }

    @IBAction func centerButtonClicked(_ sender: UIButton) {
        let londonLocation = CLLocation(latitude: 51.509865, longitude: -0.118092)
        //mapView.setCenter(londonLocation.coordinate, animated: true)
        
        // Span: 1 ~ 111km
        let region = MKCoordinateRegion(center: londonLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        self.mapView.setRegion(region, animated: true)
    }
}

