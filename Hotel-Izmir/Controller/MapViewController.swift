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
    private var places: [PlaceAnnotaiton] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManagerUpdates()
        mapView.showsUserLocation = true
        checkLocationAuthorization()
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
            findNearbyPlaces(by: "Hotel İzmir")
                        
            break
            
        @unknown default:
            break
        }
    }
    
    private func presentPlacesSheet(places: [PlaceAnnotaiton]) {
        guard let locationManager = locationManager,
              let userLocation = locationManager.location else { return }
        
        let placesTableViewController = PlacesTableViewController(userLocation: userLocation, places: places)
        placesTableViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = placesTableViewController.sheetPresentationController{
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .large()]
            present(placesTableViewController, animated: true)
        }
    }
    
    private func findNearbyPlaces(by query: String) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self ] response, error in
            guard let response = response, error == nil else { return }
            print(response.mapItems)
            self?.places = response.mapItems.map(PlaceAnnotaiton.init)
            self?.places.forEach { place in
                self?.mapView.addAnnotation(place)
            }
            if let places = self?.places {
                self?.presentPlacesSheet(places: places)
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

extension MapViewController: MKMapViewDelegate {
    
    private func clearAllSelections() {
        self.places = self.places.map({ place in
            place.isSelected = false
            return place
        })
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        clearAllSelections()
        
        guard let selectionAnnotation = annotation as? PlaceAnnotaiton else { return }
        let placeAnnotaiton = self.places.first(where: { $0.id == selectionAnnotation.id })
        placeAnnotaiton?.isSelected = true
        presentPlacesSheet(places: self.places)
    }
    
    
}


