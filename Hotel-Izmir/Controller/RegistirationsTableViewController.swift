//
//  RegistirationsTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 9.03.2023.
//

import UIKit

class RegistirationsTableViewController: UITableViewController {
    //MARK: UI- Elements
    
    //MARK: Properties
    var registirations = [RegistirationModel]()
    let identifier = "RegistirationCell"
    let detailID = "customerRegistirationDetail"
    let storyboardID = "CustomerDetailTableViewController"
    let selectedRow: RegistirationModel! = nil
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: FUNCTIONS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registirations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let registiration = registirations[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        let checkInString = dateFormatter.string(from: registiration.checkInDate)
        let checkOutString = dateFormatter.string(from: registiration.checkOutDate)
        let shortNameString = registiration.roomType.shortName
        
        cell.textLabel?.text = registiration.fullName()
        cell.detailTextLabel?.text = "\(checkInString) - \(checkOutString) ➡️ \(shortNameString)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: storyboardID) as? CustomerDetailTableViewController
        let registiration = registirations[indexPath.row]
        vc?.fullName = registiration.fullName()
        vc?.email = registiration.emailAdress
        
        vc?.checkIn = registiration.checkInDate
        vc?.checkOut = registiration.checkOutDate
        
        vc?.numberOfAdults = String(registiration.numberOfAdults)
        vc?.numberOfChildren = String(registiration.numberOfChildren)
        
        vc?.hasWifi = registiration.wifi
        
        vc?.roomName = registiration.roomType.name
        vc?.roomShortName = registiration.roomType.shortName
        vc?.roomPrice = registiration.roomType.price
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    //MARK: ACTIONS
    @IBAction func unwindFromAddRegistiration(unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? AddRegistirationTableViewController,
              let registiration = source.registiration else { return }
        registirations.append(registiration)
        tableView.reloadData()
        
    }
}
