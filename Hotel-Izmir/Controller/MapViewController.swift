//
//  MapViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 11.03.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var mapView: MKMapView!

    //MARK: PROPERTIES
    //Hem instance hem property olarak oluşturduk.
    var locationManager: CLLocationManager? = CLLocationManager()
    let distanceSpan: CLLocationDistance = 500
    let locationLatLon = CLLocation(latitude: 39.82, longitude: -86.344235)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerUpdates()
        mapView.showsUserLocation = true
        checkLocationAuthorization()
    }
    
    private func zoomLevel(location: CLLocation) {
        let mapCoordinates = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        mapView.setRegion(mapCoordinates, animated: true)
    }
    
    private func locationManagerUpdates() {
        //Kullanıcıya Map özelliğini kullanabilmek adına uygulama açıldığında istekte bulunuyoruz.
        locationManager?.delegate = self //delegation
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.requestLocation()
         
        locationManager?.startUpdatingLocation()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            
            let alertName: String = "alertViewRestricted"
            alertActions(actionName: alertName)
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
        
        case .notDetermined, .denied:
            let alertName: String = "alertViewNotDetermined_Denied"
            alertActions(actionName: alertName)
            
            
        case .restricted:
            let alertName: String = "alertViewRestricted"
            print("restricted")
            alertActions(actionName: alertName)
            
        @unknown default:
            print("unknown default")
        }
    }
    
    func alertActions(actionName: String) {
        let alertViewNotDetermined_Denied = UIAlertController(title: "Not Authorized", message: "Location services for the Hotel Izmir is denied or not determined yet. Please check the authorizations for the app.", preferredStyle: .alert)
        alertViewNotDetermined_Denied.addAction(UIAlertAction(title: "Open in Settings", style: .default, handler: { _ in
            //burası
        }))
        
        let alertViewRestricted = UIAlertController(title: "Restricted", message: "Location services for the hotel Izmir is restricted. Please check the authorizations for the app.", preferredStyle: .alert)
        alertViewRestricted.addAction(UIAlertAction(title: "Open in Settings", style: .default, handler: { _ in
            //burası
        }))
        alertViewRestricted.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertViewNotDetermined_Denied.addAction(UIAlertAction(title: "OK", style: .cancel))
        if actionName == "alertViewNotDetermined_Denied" {
            self.present(alertViewNotDetermined_Denied, animated: true)
        } else if actionName == "alertViewRestricted"{
            self.present(alertViewRestricted, animated: true)
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Konumun update edillip edilmediğini kontrol eder.
        
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //Location manager'ın yetkilendirilmesinin değiştirilip değiştirilmediğini kontrol eder.
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
