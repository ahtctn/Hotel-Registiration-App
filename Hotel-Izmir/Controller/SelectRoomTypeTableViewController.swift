//
//  SelectRoomTypeTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 9.03.2023.
//

import UIKit

class SelectRoomTypeTableViewController: UITableViewController {
    //MARK: UIELEMENTS
    //MARK: PROPERTIES
    let identifier: String = "RoomTypeCell"
    var selectedRoomType: RoomTypeModel?
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: FUNCTIONS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomTypeModel.allRoomTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let roomType = RoomTypeModel.allRoomTypes[indexPath.row]
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "\(roomType.price) ₺"
        
        if roomType == self.selectedRoomType {
            //O an çizilmekte olan oda türü, önceden seçilen oda türü mü?
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRoomType = RoomTypeModel.allRoomTypes[indexPath.row]
        tableView.reloadData()
    }
    
    //MARK: ACTIONS
}
