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
    var locationManager: CLLocationManager?
    let distanceSpan: CLLocationDistance = 500
    let locationLatLon = CLLocation(latitude: 39.82, longitude: -86.344235)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerUpdates()
        mapLogicalUpdates()
        checkLocationAuthorization()
        zoomLevel(location: locationLatLon)
    }
    
    private func mapLogicalUpdates(){
        mapView.showsUserLocation = true
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
            zoomLevel(location: locationLatLon)
            
        case .restricted:
            print("restricted")
        case .notDetermined, .denied:
            print("not determined, denied")
            
        @unknown default:
            print("unknown default")
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
