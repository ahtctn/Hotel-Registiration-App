//
//  RoomDetailViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 11.03.2023.
//

import UIKit

class RoomDetailViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roomDescription: UITextView!

    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var hasHotWater: UILabel!
    
    //MARK: PROPERTIES
    var roomImageProperty: UIImage = UIImage(systemName: "person.fill")!
    var nameProperty: String = ""
    var shortName: String = ""
   
    var roomDescriptionProperty: String = ""
    var price1: Int = 0

    var hasHotWaterProperty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabelsWithTheProperties()
    }
    
    func updateLabelsWithTheProperties() {
        roomImage.image = roomImageProperty
        name.text = nameProperty
        roomDescription.text = roomDescriptionProperty
        priceLabel.text = "\(price1) ₺"
        
        if hasHotWaterProperty {
            hasHotWater.text = "✅ Not: Sıcak su bulunmaktadır."
        } else {
            hasHotWater.text = "⭕️ Not sıcak su bulunmamaktadır."
        }
    }
}
