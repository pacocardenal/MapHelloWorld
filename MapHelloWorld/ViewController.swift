import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        addSomePinsToMap()
    }

    @IBAction func centerButtonClicked(_ sender: UIButton) {
        let londonLocation = CLLocation(latitude: 51.509865, longitude: -0.118092)
        //mapView.setCenter(londonLocation.coordinate, animated: true)
        
        // Span: 1 ~ 111km
        let region = MKCoordinateRegion(center: londonLocation.coordinate, span: MKCoordinateSpanMake(0.2, 0.2))
        self.mapView.setRegion(region, animated: true)
    }
    
    func addSomePinsToMap() {
        let a1 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 51.5091, longitude: -0.118))
        a1.title = "Pin 1"
        a1.subtitle = "Subtitle 1"
        self.mapView.addAnnotation(a1)
        
        let a2 = MapPin(coordinate: CLLocationCoordinate2D(latitude: 51.5092, longitude: -0.119))
        a2.title = "Pin 2"
        a2.subtitle = "Subtitle 2"
        self.mapView.addAnnotation(a2)
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.first.debugDescription)
    }
    
}

extension ViewController: MKMapViewDelegate {
    
    func mapViewWillStartLoadingMap(_ mapView: MKMapView) {
        print("Start loading")
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Finish loading")
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Start rendering")
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        print("Finish rendering")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        let reuseIdentifier = "myAnnotationView"
        if let dequeueAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier) {
            annotationView = dequeueAnnotationView
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "pin")
        }
        
        return annotationView
    }
    
}

class MapPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
}

