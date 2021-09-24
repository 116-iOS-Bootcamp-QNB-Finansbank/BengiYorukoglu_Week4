//
//  MapViewController.swift
//  BasicUIComponents
//
//  Created by Semih Emre ÜNLÜ on 18.09.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    private var locationManager: CLLocationManager?;
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        self.view.addGestureRecognizer(longPressGesture)
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Auth Always")
            locationManager!.requestLocation()
        case .denied, .restricted:
            print("Denied")
            presentRequestDialog()
            locationManager!.requestWhenInUseAuthorization()
        case .notDetermined:
            print("Not Determined")
            locationManager!.requestAlwaysAuthorization()
        @unknown default:
            fatalError()
        }
       
    }
    func presentRequestDialog(){
        let alert = UIAlertController(title: "Konum İzni", message: "Uygulamayı kullanmaya devam edebilmeniz için lütfen ayarlardan konum izni veriniz.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: { action in
            switch action.style{
                case .default:
                    if let bundleId = Bundle.main.bundleIdentifier,
                       let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)") {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkLocaionStatus() {
        print("Arthasss")
        
    }

    @objc func handleLongGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Adress"
        mapView.addAnnotation(annotation)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudeLabel.text = "latitude: \(String(describing: locations.first?.coordinate.latitude))"
        longitudeLabel.text = "longitude: \(locations.first?.coordinate.longitude)"
        
        if let coordinate = locations.first?.coordinate {
            mapView.setCenter(coordinate, animated: true)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
   
}

extension MapViewController: CLLocationManagerDelegate {

}

extension MapViewController: MKMapViewDelegate {
    
}
