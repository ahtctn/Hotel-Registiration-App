//
//  PlacesTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 13.03.2023.
//

import UIKit
import MapKit

class PlacesTableViewController: UITableViewController {
    //MARK: PROPERTIES
    var userLocation: CLLocation? = nil //burada ileride problem çıkabilir.
    var places: [PlaceAnnotaiton]
    private var indexForSelectedRow: Int? {
        self.places.firstIndex(where: {$0.isSelected == true})
    }
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    init(userLocation: CLLocation? = nil, places: [PlaceAnnotaiton]) {
        self.userLocation = userLocation
        self.places = places
        super.init(nibName: nil, bundle: nil)
        
        //register cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PlaceCell")
        self.places.swapAt(indexForSelectedRow ?? 0 , 0)
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implementedc")
    }
    
    //MARK: FUNCTIONS
    private func calculateDistance(from: CLLocation, to: CLLocation) -> CLLocationDistance {
        from.distance(from: to)
    }
    
    private func formatDistanceForDisplay(_ distance: CLLocationDistance) -> String {
        let meters = Measurement(value: distance, unit: UnitLength.meters)
        return meters.converted(to: .kilometers).formatted()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        places.count
    }
    
    //MARK: TABLE VIEW DELEGATE FUNCTIONS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell", for: indexPath)
        let place = places[indexPath.row]
        
        //cell configuration
        var content = cell.defaultContentConfiguration()
        content.text = place.name
        content.secondaryText = formatDistanceForDisplay(calculateDistance(from: userLocation!, to: place.location))
        cell.contentConfiguration = content
        
        cell.backgroundColor = place.isSelected ? UIColor.lightGray: UIColor.clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        let placeDetailViewController = PlaceMapDetailViewController(place: place)
        present(placeDetailViewController, animated: true)
    }
}
