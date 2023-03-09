//
//  CustomerDetailTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 9.03.2023.
//

import UIKit

class CustomerDetailTableViewController: UITableViewController {

    //MARK: OUTLETS
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    
    @IBOutlet weak var hasWifiLabel: UILabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    @IBOutlet weak var internetPriceLabel: UILabel!
    @IBOutlet weak var roomPriceLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    //MARK: PROPERTIES
    var fullName: String = ""
    var email: String = ""
    
    var checkIn = Date()
    var checkOut = Date()
    
    var numberOfAdults: String = ""
    var numberOfChildren: String = ""
    
    var hasWifi: Bool = false
    var roomName: String = ""
    var roomShortName: String = ""
    
    
    var internetPrice: Int = 0
    var roomPrice: Int = 0
    var totalPrice: String = ""
    
    let dateFormatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLifecycle()
    }
    
    func updateLifecycle() {
        dateFormatter.dateStyle = .full
        
        
        fullNameLabel.text = fullName
        emailLabel.text = email
        checkInDateLabel.text = ""
        checkOutDateLabel.text = ""
        numberOfAdultsLabel.text = numberOfAdults
        numberOfChildrenLabel.text = numberOfChildren
        
        if hasWifi == true {
            hasWifiLabel.text = "Yes"
            internetPrice = 10
        } else {
            hasWifiLabel.text = "No"
            internetPrice = 0
        }
        
        let internetAndRoomPriceInt = internetPrice + roomPrice
        
        roomTypeLabel.text = "\(roomName)- \(roomShortName)"
        
        internetPriceLabel.text = String("\(internetPrice) ₺")
        roomPriceLabel.text = String("\(roomPrice) ₺")
        totalPriceLabel.text = String("\(internetAndRoomPriceInt) ₺")
    }
    
    
}
