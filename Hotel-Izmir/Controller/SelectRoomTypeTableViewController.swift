//
//  SelectRoomTypeTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 9.03.2023.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate: AnyObject {
    //class: Protokolün yalnızca Class'lar tarafından desteklenebileceğini belirtmek için kullanılır
    func didSelect(roomType: RoomTypeModel)
}

class SelectRoomTypeTableViewController: UITableViewController {
    //MARK: UIELEMENTS
    
    //MARK: PROPERTIES
    let identifier: String = "RoomTypeCell"
    var selectedRoomType: RoomTypeModel?
    weak var delegate: SelectRoomTypeTableViewControllerDelegate?
    //Normalde değişkenler, hangi sınıfta tanımlandıysa aralarında strong relation kurar
    //Fakat biz bu değişkeni 'weak' olarak tanımladığımızdan dolayı şu anda delegate yaşadığı zaman
    //Class yaşamak zorunda değildir. Çünkü aslında delegate bir önceki sayfanın referansıdır.
    //Bundan dolayı iki class arasında anlamsız bir strong relationship'e gerek duyulmamaktadır.
    
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
        delegate?.didSelect(roomType: selectedRoomType!)
        tableView.reloadData()
    }
    
    //MARK: ACTIONS
}
