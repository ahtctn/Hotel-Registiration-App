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
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManagerUpdates()
        mapLogicalUpdates()
    }
    
    func mapLogicalUpdates(){
        mapView.showsUserLocation = true
    }
    
    func locationManagerUpdates() {
        //Kullanıcıya Map özelliğini kullanabilmek adına uygulama açıldığında istekte bulunuyoruz.
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()

    }
    

   

}
