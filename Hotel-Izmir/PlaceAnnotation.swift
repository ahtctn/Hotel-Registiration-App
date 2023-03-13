//
//  PlaceAnnotation.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 13.03.2023.
//

import Foundation
import MapKit

class PlaceAnnotaiton: MKPointAnnotation {
    let mapItem: MKMapItem
    let id = UUID()
    var isSelected: Bool = false 
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate
    }
    
    var name: String {
        mapItem.name ?? ""
    }
    
    var phone: String {
        mapItem.phoneNumber ?? ""
    }
    
    var address: String {
        "\(mapItem.placemark.subThoroughfare ?? "") \(mapItem.placemark.thoroughfare ?? "") \(mapItem.placemark.locality ?? "") \(mapItem.placemark.countryCode ?? "")"
    }
    
    var location: CLLocation {
        mapItem.placemark.location ?? CLLocation.defaultLocation
    }
}
