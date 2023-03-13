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
    @IBOutlet weak var goToSettingsView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var goToSettingsButton: UIButton!

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
        
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            deniedCase()
        case .restricted:
            restrictedCase()
        
        case .authorizedWhenInUse, .authorizedAlways:
            goToSettingsView.isHidden = true
            warningLabel.isHidden = true
            goToSettingsButton.isHidden = true
            
            let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 750, longitudinalMeters: 750)
            mapView.setRegion(region, animated: true)
            findNearbyPlaces(by: "Hotel")
                        
            break
            
        @unknown default:
            break
        }
    }
    
    private func findNearbyPlaces(by query: String) {
        //clear all annotations
        //mapView.removeAnnotation(mapView.annotations as! MKAnnotation)
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self ] response, error in
            guard let response = response, error == nil else { return }
            print(response.mapItems)
            let places = response.mapItems.map(PlaceAnnotaiton.init)
            places.forEach { place in
                self?.mapView.addAnnotation(place)
            }
        }
    }
    
    
    private func deniedCase() {
        let alertDenied = UIAlertController(title: "Not Authorized", message: "Location services for the Hotel Izmir is denied or not determined yet. Please check the authorizations for the app.", preferredStyle: .alert)
        alertDenied.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertDenied.addAction(UIAlertAction(title: "Open In Settings", style: .default, handler: { _ in
            self.goToSettings()
        }))
        self.present(alertDenied, animated: true)
    }
    
    private func restrictedCase() {
        let alertViewRestricted = UIAlertController(title: "Restricted", message: "Location services for the hotel Izmir is restricted. Please check the authorizations for the app.", preferredStyle: .alert)
        alertViewRestricted.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertViewRestricted.addAction(UIAlertAction(title: "Open In Settings", style: .default, handler: { _ in
            self.goToSettings()
        }))
        self.present(alertViewRestricted, animated: true)
    }
    
    private func goToSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    //MARK: ACTIONS
    @IBAction func goToSettingsButtonTapped(_ button: UIButton) {
        goToSettings()
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
